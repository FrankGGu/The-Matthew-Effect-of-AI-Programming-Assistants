-module(solution).
-export([next_greater_elements/1]).

next_greater_elements(Nums) ->
    N = length(Nums),
    if N == 0 ->
        [];
    true ->
        NumsArray = array:from_list(Nums),
        ResultArray = array:new(N, {default, -1}),
        Stack = [], % Stores 0-indexed indices

        ResultArrayFinal = next_greater_elements_loop(2*N - 1, N, NumsArray, ResultArray, Stack),
        array:to_list(ResultArrayFinal)
    end.

next_greater_elements_loop(I, N, NumsArray, ResultArray, Stack) when I >= 0 ->
    CurrentIndex = I rem N,
    CurrentValue = array:get(CurrentIndex, NumsArray),

    % Pop elements from stack whose values are less than or equal to CurrentValue
    NewStack = pop_smaller_or_equal(Stack, NumsArray, CurrentValue),

    % If stack is not empty, the top element is the next greater element
    UpdatedResultArray =
        case NewStack of
            [] ->
                ResultArray;
            [TopIndex | _] ->
                array:set(CurrentIndex, array:get(TopIndex, NumsArray), ResultArray)
        end,

    % Push CurrentIndex onto the stack
    UpdatedStack = [CurrentIndex | NewStack],

    % Recurse for the next iteration
    next_greater_elements_loop(I - 1, N, NumsArray, UpdatedResultArray, UpdatedStack);
next_greater_elements_loop(_I, _N, _NumsArray, ResultArray, _Stack) ->
    ResultArray.

pop_smaller_or_equal(Stack, NumsArray, CurrentValue) ->
    case Stack of
        [] ->
            [];
        [TopIndex | RestStack] ->
            TopValue = array:get(TopIndex, NumsArray),
            if TopValue =< CurrentValue ->
                % Pop this element and continue checking the rest of the stack
                pop_smaller_or_equal(RestStack, NumsArray, CurrentValue);
            true ->
                % Top element is greater, stop popping
                Stack
            end
    end.