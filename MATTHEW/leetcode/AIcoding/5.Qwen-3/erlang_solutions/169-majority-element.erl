-module(majority_element).
-export([majorityElement/1]).

majorityElement(Nums) ->
    majorityElement(Nums, 0, 0).

majorityElement([], _Candidate, _Count) ->
    _Candidate;

majorityElement([H | T], Candidate, Count) ->
    case Count of
        0 ->
            majorityElement(T, H, 1);
        _ ->
            if
                H == Candidate ->
                    majorityElement(T, Candidate, Count + 1);
                true ->
                    majorityElement(T, Candidate, Count - 1)
            end
    end.