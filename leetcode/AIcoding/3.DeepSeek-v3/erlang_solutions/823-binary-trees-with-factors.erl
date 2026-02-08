-module(solution).
-export([num_factored_binary_trees/1]).

num_factored_binary_trees(Arr) ->
    Sorted = lists:sort(Arr),
    Map = maps:from_list([{X, 1} || X <- Sorted]),
    {_, Result} = lists:foldl(fun(A, {M, Sum}) ->
        case get_factors(A, Sorted, M) of
            0 -> {M, Sum + 1};
            Count -> {maps:put(A, Count + 1, M), Sum + Count + 1}
        end
    end, {Map, 0}, Sorted),
    Result rem 1000000007.

get_factors(A, Sorted, Map) ->
    lists:foldl(fun(B, Acc) ->
        case A rem B of
            0 ->
                C = A div B,
                case maps:is_key(C, Map) of
                    true -> Acc + maps:get(B, Map) * maps:get(C, Map);
                    false -> Acc
                end;
            _ -> Acc
        end
    end, 0, lists:takewhile(fun(X) -> X * X =< A end, Sorted)).