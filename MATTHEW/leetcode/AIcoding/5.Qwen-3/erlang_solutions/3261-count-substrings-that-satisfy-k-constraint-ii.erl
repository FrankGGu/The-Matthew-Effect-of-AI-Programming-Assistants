-module(solution).
-export([count_k_constrained_substrings/1]).

count_k_constrained_substrings(S) ->
    N = length(S),
    Count = 0,
    lists:foldl(fun(I, Acc) ->
        lists:foldl(fun(J, Acc2) ->
            Sub = lists:sublist(S, I, J - I + 1),
            if
                is_valid(Sub) -> Acc2 + 1;
                true -> Acc2
            end
        end, Acc, lists:seq(I + 1, N))
    end, Count, lists:seq(1, N)).

is_valid(Sub) ->
    Counts = lists:foldl(fun(Char, Acc) ->
        maps:update_with(Char, fun(V) -> V + 1 end, 1, Acc)
    end, maps:new(), Sub),
    maps:values(Counts) == lists:sort(maps:values(Counts)).