-module(solution).
-export([reducing_dishes/1]).

reducing_dishes(Satisfaction) ->
    SortedSatisfaction = lists:sort(Satisfaction),
    ReversedSortedSatisfaction = lists:reverse(SortedSatisfaction),
    {_CurrentLikeTime, _SuffixSum, MaxLikeTime} = lists:foldl(
        fun(S_i, {CurrentLikeTime, SuffixSum, AccMaxLikeTime}) ->
            NewCurrentLikeTime = CurrentLikeTime + SuffixSum + S_i,
            if NewCurrentLikeTime > CurrentLikeTime ->
                {NewCurrentLikeTime, SuffixSum + S_i, max(AccMaxLikeTime, NewCurrentLikeTime)};
            true ->
                {CurrentLikeTime, SuffixSum, AccMaxLikeTime}
            end
        end,
        {0, 0, 0},
        ReversedSortedSatisfaction
    ),
    MaxLikeTime.