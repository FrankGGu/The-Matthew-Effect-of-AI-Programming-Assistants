-module(solution).
-export([minimumPossibleSum/2]).

minimumPossibleSum(N, Target) ->
    minimumPossibleSum_recursive(N, Target, 1, 0, sets:new()).

minimumPossibleSum_recursive(0, _Target, _CurrentNum, AccSum, _Forbidden) ->
    AccSum;
minimumPossibleSum_recursive(N, Target, CurrentNum, AccSum, Forbidden) ->
    if sets:is_element(CurrentNum, Forbidden) ->
        minimumPossibleSum_recursive(N, Target, CurrentNum + 1, AccSum, Forbidden);
    true ->
        NewAccSum = AccSum + CurrentNum,
        NewForbidden =
            case Target - CurrentNum of
                Val when Val > 0 ->
                    sets:add_element(Val, Forbidden);
                _ ->
                    Forbidden
            end,
        minimumPossibleSum_recursive(N - 1, Target, CurrentNum + 1, NewAccSum, NewForbidden)
    end.