-module(solution).
-export([longestSubsequence/2]).

longestSubsequence(S, K) ->
    NumZeros = lists:sum([1 || C <- S, C == $0]),

    acc([], _CurrentValue, CurrentLengthOnes, _PlaceValue, _K) ->
        CurrentLengthOnes;

    acc([C|Rest], CurrentValue, CurrentLengthOnes, PlaceValue, K) ->
        if PlaceValue > K ->
            CurrentLengthOnes;
        true ->
            case C of
                $1 ->
                    if CurrentValue + PlaceValue =< K ->
                        acc(Rest, CurrentValue + PlaceValue, CurrentLengthOnes + 1, PlaceValue * 2, K);
                    true ->
                        CurrentLengthOnes
                    end;
                $0 ->
                    acc(Rest, CurrentValue, CurrentLengthOnes, PlaceValue * 2, K)
            end
        end.

    OnesCount = acc(lists:reverse(S), 0, 0, 1, K),

    NumZeros + OnesCount.