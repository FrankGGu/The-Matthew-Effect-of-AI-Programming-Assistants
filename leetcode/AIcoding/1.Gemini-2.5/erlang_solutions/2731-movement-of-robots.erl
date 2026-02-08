-module(solution).
-export([sum_distances/3]).

sum_distances(Nums, S, K) ->
    Mod = 1000000007,
    S_chars = binary_to_list(S),
    InitialData = lists:zip(Nums, S_chars),
    SortedInitialData = lists:sort(fun({P1, _}, {P2, _}) -> P1 =< P2 end, InitialData),
    {SortedInitialPositions, HypotheticalFinalPositions} =
        lists:foldl(fun({Pos, Dir}, {AccP, AccH}) ->
                        HypotheticalFinalPos =
                            case Dir of
                                $R -> Pos + K;
                                $L -> Pos - K
                            end,
                        {[Pos | AccP], [HypotheticalFinalPos | AccH]}
                    end, {[], []}, SortedInitialData),
    SortedInitialPositionsReversed = lists:reverse(SortedInitialPositions),
    HypotheticalFinalPositionsReversed = lists:reverse(HypotheticalFinalPositions),
    SortedHypotheticalFinalPositions = lists:sort(HypotheticalFinalPositionsReversed),
    PairsForSum = lists:zip(SortedHypotheticalFinalPositions, SortedInitialPositionsReversed),
    Sum = lists:foldl(fun({H_final, P_initial}, AccSum) ->
                          Diff = abs(H_final - P_initial),
                          (AccSum + Diff) rem Mod
                      end, 0, PairsForSum),
    Sum.