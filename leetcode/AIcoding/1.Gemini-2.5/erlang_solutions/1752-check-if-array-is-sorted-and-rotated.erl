-module(solution).
-export([check/1]).

-spec check(Nums :: [integer()]) -> boolean().
check(Nums) ->
    Len = length(Nums),
    if
        Len =< 1 -> true;
        true ->
            CountDips = count_dips(Nums, 0),
            case CountDips of
                0 -> true;
                1 -> lists:last(Nums) =< hd(Nums);
                _ -> false
            end
    end.

count_dips([], Acc) -> Acc;
count_dips([_], Acc) -> Acc;
count_dips([H1, H2 | T], Acc) ->
    NewAcc = if H1 > H2 -> Acc + 1; true -> Acc end,
    count_dips([H2 | T], NewAcc).