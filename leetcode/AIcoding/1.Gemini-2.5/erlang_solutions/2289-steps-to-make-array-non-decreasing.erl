-module(solution).
-export([total_steps/1]).

total_steps(Nums) ->
    {_FinalStack, MaxSteps} = lists:foldl(
        fun(Num, {Stack, CurrentMaxSteps}) ->
            {CountForSmaller, StackAfterPopSmaller} = pop_strictly_smaller(Num, Stack, 0),

            case StackAfterPopSmaller of
                [] ->
                    {[{Num, 0}], CurrentMaxSteps};
                [{TopVal, TopDp} | RestStack] when TopVal == Num ->
                    {[{Num, TopDp} | RestStack], max(CurrentMaxSteps, TopDp)};
                [{TopVal, _} | _] when TopVal > Num ->
                    Dp_i = CountForSmaller + 1,
                    {[{Num, Dp_i} | StackAfterPopSmaller], max(CurrentMaxSteps, Dp_i)}
            end
        end,
        {[], 0},
        Nums
    ),
    MaxSteps.

pop_strictly_smaller(Num, Stack, AccCount) ->
    case Stack of
        [] ->
            {AccCount, []};
        [{TopVal, TopDp} | RestStack] when TopVal < Num ->
            pop_strictly_smaller(Num, RestStack, max(AccCount, TopDp + 1));
        _ ->
            {AccCount, Stack}
    end.