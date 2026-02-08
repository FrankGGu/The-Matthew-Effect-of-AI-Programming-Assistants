-module(solution).
-export([longest_subarray/1]).

longest_subarray(Nums) ->
    longest_subarray_impl(Nums, 0, 0, 0, false).

longest_subarray_impl([], MaxSoFar, CurrentBlock, PreviousBlock, FoundAZero) ->
    Result = max(MaxSoFar, CurrentBlock + PreviousBlock),
    case FoundAZero of
        true -> Result;
        false ->
            % If no zeros were found, it means all elements were 1s.
            % We must delete one element, so the length is N-1.
            % If N is 0 or 1, N-1 would be negative or 0. The minimum length is 0.
            max(0, Result - 1)
    end;
longest_subarray_impl([0 | Rest], MaxSoFar, CurrentBlock, PreviousBlock, _FoundAZero) ->
    NewMaxSoFar = max(MaxSoFar, CurrentBlock + PreviousBlock),
    longest_subarray_impl(Rest, NewMaxSoFar, 0, CurrentBlock, true);
longest_subarray_impl([1 | Rest], MaxSoFar, CurrentBlock, PreviousBlock, FoundAZero) ->
    longest_subarray_impl(Rest, MaxSoFar, CurrentBlock + 1, PreviousBlock, FoundAZero).