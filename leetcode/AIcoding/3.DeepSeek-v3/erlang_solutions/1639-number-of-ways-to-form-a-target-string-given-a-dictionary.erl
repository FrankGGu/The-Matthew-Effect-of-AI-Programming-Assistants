-module(solution).
-export([num_ways/2]).

num_ways(Words, Target) ->
    Mod = 1000000007,
    M = length(Words),
    N = length(hd(Words)),
    K = length(Target),
    if
        K > N -> 0;
        true ->
            Count = lists:foldl(fun(_, Acc) -> 
                                    [lists:duplicate(26, 0) | Acc]
                                end, [], lists:seq(1, N)),
            Count1 = lists:foldl(fun(Word, Acc) ->
                                    lists:foldl(fun({Ch, Pos}, AccIn) ->
                                                    Index = Ch - $a,
                                                    Row = lists:nth(Pos, AccIn),
                                                    NewRow = setelement(Index + 1, Row, element(Index + 1, Row) + 1),
                                                    setelement(Pos, AccIn, NewRow)
                                                end, Acc, lists:zip(Word, lists:seq(1, N)))
                                end, Count, Words),
            DP = lists:duplicate(K + 1, lists:duplicate(N + 1, 0)),
            DP1 = setelement(1, DP, [1 | lists:nth(1, DP)]),
            DP2 = lists:foldl(fun(I, DPAcc) ->
                                lists:foldl(fun(J, InnerAcc) ->
                                                Val = lists:nth(I, lists:nth(J, InnerAcc)),
                                                if
                                                    I > K -> InnerAcc;
                                                    J > N -> InnerAcc;
                                                    true ->
                                                        Ch = lists:nth(I, Target),
                                                        Index = Ch - $a,
                                                        Cnt = element(Index + 1, lists:nth(J, Count1)),
                                                        Prev = lists:nth(I, lists:nth(J, InnerAcc)),
                                                        Next = lists:nth(I + 1, lists:nth(J + 1, InnerAcc)),
                                                        NewVal = (Prev + (Cnt * Next) rem Mod) rem Mod,
                                                        NewRow = setelement(J, lists:nth(I, InnerAcc), NewVal),
                                                        setelement(I, InnerAcc, NewRow)
                                                end
                                            end, DPAcc, lists:seq(1, N + 1))
                            end, DP1, lists:seq(1, K + 1)),
            lists:nth(1, lists:nth(K + 1, DP2))
    end.