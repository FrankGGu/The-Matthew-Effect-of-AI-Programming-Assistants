-module(solution).
-export([special_perm/1]).

special_perm(Nums) ->
    N = length(Nums),
    DP = maps:new(),
    solve(Nums, (1 bsl N) - 1, -1, DP).

solve(Nums, Mask, Prev, DP) ->
    case maps:find({Mask, Prev}, DP) of
        {ok, Val} ->
            Val;
        error ->
            if
                Mask =:= 0 ->
                    1;
                true ->
                    Sum = lists:foldl(
                        fun(I, Acc) ->
                            case (Mask band (1 bsl I)) =/= 0 of
                                true ->
                                    Num = lists:nth(I + 1, Nums),
                                    if
                                        Prev =:= -1 orelse Num rem Prev =:= 0 orelse Prev rem Num =:= 0 ->
                                            Acc + solve(Nums, Mask bxor (1 bsl I), Num, DP);
                                        true ->
                                            Acc
                                    end;
                                false ->
                                    Acc
                            end
                        end,
                        0,
                        lists:seq(0, length(Nums) - 1)),
                    maps:put({Mask, Prev}, Sum, DP),
                    Sum
            end
    end.