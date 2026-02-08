-module(solution).
-export([next_greater_element/1]).

next_greater_element(Nums) ->
    N = length(Nums),
    Ans = array:new([{size, N}, {fixed, true}, {default, -1}]),
    NumsT = list_to_tuple(Nums),

    InitialState = {Ans, [], []},

    FinalState = lists:foldl(
        fun(I, {CurrentAns, S1, S2}) ->
            NumI = element(I + 1, NumsT),

            {NewS2_after_pop, Ans_after_s2} = pop_s2_helper(S2, NumI, NumsT, CurrentAns),

            {NewS1_after_pop, TempS2Candidates} = pop_s1_helper(S1, NumI, NumsT, []),

            S1_after_push = [I | NewS1_after_pop],

            S2_after_push = lists:foldl(fun(Idx, AccS2) ->
                                            [Idx | AccS2]
                                        end, NewS2_after_pop, lists:reverse(TempS2Candidates)),

            {Ans_after_s2, S1_after_push, S2_after_push}
        end,
        InitialState,
        lists:seq(0, N - 1)
    ),

    {FinalAnsArray, _, _} = FinalState,
    array:to_list(FinalAnsArray).

pop_s2_helper(S2, NumI, NumsT, CurrentAns) ->
    case S2 of
        [] ->
            {[], CurrentAns};
        [HeadIdx | TailS2] when element(HeadIdx + 1, NumsT) < NumI ->
            UpdatedAns = array:set(HeadIdx, NumI, CurrentAns),
            pop_s2_helper(TailS2, NumI, NumsT, UpdatedAns);
        _ ->
            {S2, CurrentAns}
    end.

pop_s1_helper(S1, NumI, NumsT, AccTempS2Candidates) ->
    case S1 of
        [] ->
            {[], AccTempS2Candidates};
        [HeadIdx | TailS1] when element(HeadIdx + 1, NumsT) < NumI ->
            pop_s1_helper(TailS1, NumI, NumsT, [HeadIdx | AccTempS2Candidates]);
        _ ->
            {S1, AccTempS2Candidates}
    end.