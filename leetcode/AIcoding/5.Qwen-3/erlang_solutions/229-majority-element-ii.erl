-module(majority_element_ii).
-export([majorityElement/1]).

majorityElement(Nums) ->
    {Candidate1, Candidate2, Count1, Count2} = findCandidates(Nums, 0, 0, 0, 0),
    validate(Nums, Candidate1, Candidate2).

findCandidates([], C1, C2, _, _) ->
    {C1, C2, 0, 0};
findCandidates([H | T], C1, C2, Count1, Count2) ->
    case H of
        C1 ->
            findCandidates(T, C1, C2, Count1 + 1, Count2);
        C2 ->
            findCandidates(T, C1, C2, Count1, Count2 + 1);
        _ when Count1 == 0 ->
            findCandidates(T, H, C2, 1, Count2);
        _ when Count2 == 0 ->
            findCandidates(T, C1, H, Count1, 1);
        _ ->
            findCandidates(T, C1, C2, Count1 - 1, Count2 - 1)
    end.

validate(Nums, C1, C2) ->
    Count1 = count(Nums, C1),
    Count2 = count(Nums, C2),
    Result = [],
    if
        Count1 > length(Nums) div 3 ->
            [C1 | Result];
        true ->
            Result
    end,
    if
        Count2 > length(Nums) div 3 andalso C2 /= C1 ->
            [C2 | Result];
        true ->
            Result
    end.

count([], _) ->
    0;
count([H | T], Val) ->
    if
        H == Val ->
            1 + count(T, Val);
        true ->
            count(T, Val)
    end.