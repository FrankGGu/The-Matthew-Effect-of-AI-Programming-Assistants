-module(solution).
-export([solve/1]).

-include_lib("kernel/include/gb_arrays.hrl"). % Include gb_array module for balanced arrays

solve(Nums) ->
    N = length(Nums),
    LISLength = lis_length(Nums),
    N - LISLength.

lis_length(Nums) ->
    % TailsArray stores the smallest tail of all increasing subsequences of length i+1 at index i.
    % It is always sorted.
    TailsArray = gb_array:new(),
    FinalTailsArray = lists:foldl(fun(Num, CurrentTailsArray) ->
                                          update_tails_gb(Num, CurrentTailsArray)
                                  end, TailsArray, Nums),
    gb_array:size(FinalTailsArray).

update_tails_gb(Num, CurrentTailsArray) ->
    Size = gb_array:size(CurrentTailsArray),
    if Size == 0 ->
        % If TailsArray is empty, start a new subsequence
        gb_array:append(Num, CurrentTailsArray);
    true ->
        % Get the last element (largest tail)
        Last = gb_array:get(Size - 1, CurrentTailsArray),
        if Num > Last ->
            % If Num is greater than the largest tail, extend the longest subsequence
            gb_array:append(Num, CurrentTailsArray);
        true ->
            % Otherwise, find the smallest element in TailsArray that is >= Num
            % and replace it with Num. This maintains the increasing property
            % but potentially allows for a shorter tail, which is better for future extensions.
            Idx = binary_search_for_replace(Num, CurrentTailsArray, 0, Size - 1),
            gb_array:set(Idx, Num, CurrentTailsArray)
        end
    end.

binary_search_for_replace(Target, Array, Low, High) ->
    if Low > High ->
        Low; % Target should be inserted at this index
    true ->
        Mid = Low + (High - Low) div 2,
        Val = gb_array:get(Mid, Array),
        if Val < Target ->
            binary_search_for_replace(Target, Array, Mid + 1, High);
        true -> % Val >= Target
            binary_search_for_replace(Target, Array, Low, Mid - 1)
        end
    end.