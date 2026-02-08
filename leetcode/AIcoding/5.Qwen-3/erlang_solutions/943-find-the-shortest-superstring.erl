-module(solution).
-export([find_shortest_superstring/1]).

find_shortest_superstring(Strings) ->
    N = length(Strings),
    if
        N == 0 -> [];
        N == 1 -> hd(Strings);
        true ->
            Cost = build_cost_matrix(Strings),
            DP = array:new(N, fun(_) -> array:new(N, fun(_) -> 0 end) end),
            Best = array:new(N, fun(_) -> -1 end),
            Path = array:new(N, fun(_) -> -1 end),
            find_shortest_superstring_dp(Strings, Cost, DP, Best, Path, N),
            reconstruct_path(Strings, Best, Path, N)
    end.

build_cost_matrix(Strings) ->
    N = length(Strings),
    build_cost_matrix(Strings, 0, N, array:new(N, fun(I) -> array:new(N, fun(J) -> 0 end) end)).

build_cost_matrix(_, _, N, Acc) when N == 0 -> Acc;
build_cost_matrix(Strings, I, N, Acc) ->
    J = I + 1,
    build_cost_matrix(Strings, I, N - 1, array:set(I, build_cost_row(Strings, I, 0, array:new(N, fun(_) -> 0 end)), Acc)).

build_cost_row(_, _, N, Acc) when N == 0 -> Acc;
build_cost_row(Strings, I, J, Acc) ->
    A = lists:nth(I + 1, Strings),
    B = lists:nth(J + 1, Strings),
    Max = min(length(A), length(B)),
    Len = case find_overlap(A, B, Max) of
              0 -> 0;
              L -> L
          end,
    build_cost_row(Strings, I, J + 1, array:set(J, length(B) - Len, Acc)).

find_overlap([], _, _) -> 0;
find_overlap(_, [], _) -> 0;
find_overlap(A, B, Max) ->
    case lists:suffix(lists:sublist(A, Max), B) of
        true -> Max;
        false -> find_overlap(lists:tl(A), B, Max - 1)
    end.

find_shortest_superstring_dp(Strings, Cost, DP, Best, Path, N) ->
    find_shortest_superstring_dp(Strings, Cost, DP, Best, Path, N, 0, 0).

find_shortest_superstring_dp(_, _, DP, Best, Path, N, I, J) when I == N -> {DP, Best, Path};
find_shortest_superstring_dp(Strings, Cost, DP, Best, Path, N, I, J) ->
    if
        I == 0 ->
            array:set(I, array:set(J, 0, DP), DP),
            find_shortest_superstring_dp(Strings, Cost, DP, Best, Path, N, I, J + 1);
        true ->
            MinCost = find_min_cost(Strings, Cost, DP, Best, Path, N, I, J),
            array:set(I, array:set(J, MinCost, DP), DP),
            find_shortest_superstring_dp(Strings, Cost, DP, Best, Path, N, I, J + 1)
    end.

find_min_cost(Strings, Cost, DP, Best, Path, N, I, J) ->
    find_min_cost(Strings, Cost, DP, Best, Path, N, I, J, 0, 0, infinity).

find_min_cost(_, _, _, _, _, N, I, J, K, _, Min) when K == N -> Min;
find_min_cost(Strings, Cost, DP, Best, Path, N, I, J, K, Current, Min) ->
    if
        K == J -> find_min_cost(Strings, Cost, DP, Best, Path, N, I, J, K + 1, Current, Min);
        true ->
            PrevCost = array:get(K, array:get(I, DP)),
            NewCost = PrevCost + array:get(K, array:get(J, Cost)),
            if
                NewCost < Min ->
                    array:set(K, array:set(I, NewCost, DP), DP),
                    array:set(I, array:set(J, K, Path), Path),
                    find_min_cost(Strings, Cost, DP, Best, Path, N, I, J, K + 1, Current, NewCost);
                true ->
                    find_min_cost(Strings, Cost, DP, Best, Path, N, I, J, K + 1, Current, Min)
            end
    end.

reconstruct_path(Strings, Best, Path, N) ->
    Start = find_start(Best, N),
    PathList = [Start],
    Next = array:get(Start, Path),
    reconstruct_path_loop(Strings, Best, Path, N, Next, PathList).

reconstruct_path_loop(_, _, _, N, -1, PathList) when N == 1 -> lists:reverse(PathList);
reconstruct_path_loop(_, _, _, N, -1, PathList) -> lists:reverse(PathList);
reconstruct_path_loop(Strings, Best, Path, N, Next, PathList) ->
    PathList2 = [Next | PathList],
    Next2 = array:get(Next, Path),
    reconstruct_path_loop(Strings, Best, Path, N, Next2, PathList2).

find_start(Best, N) ->
    find_start(Best, N, 0).

find_start(_, N, N) -> 0;
find_start(Best, N, I) ->
    if
        array:get(I, Best) == -1 -> I;
        true -> find_start(Best, N, I + 1)
    end.