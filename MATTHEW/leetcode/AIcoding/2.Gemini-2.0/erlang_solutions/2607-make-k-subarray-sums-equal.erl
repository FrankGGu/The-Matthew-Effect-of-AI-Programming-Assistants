-module(make_k_subarray_sums_equal).
-export([make_k_subarray_sums_equal/2]).

make_k_subarray_sums_equal(Arr, K) ->
    N = length(Arr),
    TrueK = K rem N,
    case TrueK of
        0 ->
            lists:sum([abs(X - median(Arr)) || X <- Arr]);
        _ ->
            Cycles = create_cycles(N, TrueK),
            lists:sum([
                cycle_cost(Arr, Cycle)
                || Cycle <- Cycles
            ])
    end.

create_cycles(N, K) ->
    create_cycles_helper(N, K, [], sets:new()).

create_cycles_helper(N, K, Acc, Visited) ->
    case sets:size(Visited) of
        N ->
            Acc;
        _ ->
            First = get_first_unvisited(N, Visited),
            Cycle = create_cycle(First, N, K),
            NewVisited = lists:foldl(
                fun(X, V) -> sets:add_element(X, V) end,
                Visited,
                Cycle
            ),
            create_cycles_helper(N, K, [Cycle | Acc], NewVisited)
    end.

get_first_unvisited(N, Visited) ->
    get_first_unvisited_helper(0, N, Visited).

get_first_unvisited_helper(I, N, Visited) ->
    case I >= N of
        true ->
            erlang:error(no_unvisited);
        false ->
            case sets:is_element(I, Visited) of
                true ->
                    get_first_unvisited_helper(I + 1, N, Visited);
                false ->
                    I
            end
    end.

create_cycle(Start, N, K) ->
    create_cycle_helper(Start, N, K, [Start], sets:new()).

create_cycle_helper(Start, N, K, Acc, Visited) ->
    case lists:member(Start, Acc) andalso length(Acc) > 1 of
        true ->
            lists:reverse(Acc);
        false ->
            Next = (lists:last(Acc) + K) rem N,
            case sets:is_element(Next, Visited) of
                true ->
                    lists:reverse(Acc);
                false ->
                    create_cycle_helper(Start, N, K, [Next | Acc], sets:add_element(Next, Visited))
            end
    end.

cycle_cost(Arr, Cycle) ->
    Values = [Arr !! I || I <- Cycle],
    lists:sum([abs(X - median(Values)) || X <- Values]).

median(List) ->
    Sorted = lists:sort(List),
    Len = length(Sorted),
    case Len rem 2 of
        0 ->
            (lists:nth(Len div 2, Sorted) + lists:nth((Len div 2) + 1, Sorted)) / 2;
        1 ->
            lists:nth((Len + 1) div 2, Sorted)
    end.