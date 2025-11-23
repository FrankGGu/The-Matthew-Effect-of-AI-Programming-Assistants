-module(solution).
-export([count_k_substrings/2]).

count_k_substrings(S, K) ->
    Count = 0,
    MaxBeauty = 0,
    lists:foldl(fun(Char, {CountAcc, MaxBeautyAcc}) ->
        case lists:member(Char, "aeiou") of
            true ->
                NewCount = CountAcc + 1,
                NewMaxBeauty = max(MaxBeautyAcc, 1),
                {NewCount, NewMaxBeauty};
            false ->
                {CountAcc, MaxBeautyAcc}
        end
    end, {0, 0}, S),
    if
        K > Count -> 0;
        true -> 1
    end.