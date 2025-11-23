-module(solution).
-export([find_number_of_subarrays/1]).

find_number_of_subarrays(Arr) ->
    find_number_of_subarrays_impl(Arr, [], #{}, 0).

find_number_of_subarrays_impl([], _Stack, _ValCounts, Ans) ->
    Ans;
find_number_of_subarrays_impl([CurrentVal|RestArr], Stack, ValCounts, Ans) ->
    %% Step 1: Pop elements from the stack that are smaller than CurrentVal.
    %% These elements can no longer be the maximum in a subarray ending at CurrentVal.
    {NewStack1, NewValCounts1} = pop_smaller_elements(Stack, ValCounts, CurrentVal),

    CurrentEqualCount = 0,
    {NewStack, NewValCounts, FinalCurrentEqualCount} = 
        case NewStack1 of
            [] ->
                %% Stack is empty, CurrentVal is the first element or all previous were smaller.
                %% Add CurrentVal to stack and ValCounts.
                {[CurrentVal], maps:put(CurrentVal, 1, NewValCounts1), CurrentEqualCount};
            [TopVal|_] when TopVal == CurrentVal ->
                %% Top of stack is equal to CurrentVal.
                %% Get existing count of TopVal (these are valid left boundaries),
                %% then add CurrentVal itself to the count.
                Count = maps:get(CurrentVal, NewValCounts1, 0),
                {[CurrentVal|NewStack1], maps:put(CurrentVal, Count + 1, NewValCounts1), Count};
            [TopVal|_] when TopVal > CurrentVal ->
                %% Top of stack is greater than CurrentVal.
                %% Add CurrentVal to stack and ValCounts.
                {[CurrentVal|NewStack1], maps:put(CurrentVal, maps:get(CurrentVal, NewValCounts1, 0) + 1, NewValCounts1), CurrentEqualCount}
        end,

    %% Add to total answer:
    %% FinalCurrentEqualCount: number of valid subarrays arr[i..j] where i < j and arr[i] == arr[j] == CurrentVal.
    %% +1: for the single-element subarray arr[j..j] (which is [CurrentVal] itself).
    NewAns = Ans + FinalCurrentEqualCount + 1,
    find_number_of_subarrays_impl(RestArr, NewStack, NewValCounts, NewAns).

pop_smaller_elements(Stack, ValCounts, CurrentVal) ->
    case Stack of
        [] ->
            {[], ValCounts};
        [TopVal|RestStack] when TopVal < CurrentVal ->
            %% Top element is smaller than CurrentVal. Pop it and decrement its count.
            NewValCounts = maps:update_with(TopVal, fun(Count) -> Count - 1 end, ValCounts),
            pop_smaller_elements(RestStack, NewValCounts, CurrentVal);
        _ ->
            %% Top element is >= CurrentVal. Stop popping.
            {Stack, ValCounts}
    end.