-module(minimum_size_subarray_infinite_array).
-export([minSubarrayLen/2]).

minSubarrayLen(Start, Target) ->
    minSubarrayLen(Start, Target, 0, 0, 1).

minSubarrayLen(Start, Target, Sum, Length, Step) ->
    if
        Sum >= Target -> Length;
        true ->
            NextSum = Sum + Start + (Step - 1) * 2,
            NextLength = Length + 1,
            NextStep = Step + 1,
            minSubarrayLen(Start, Target, NextSum, NextLength, NextStep)
    end.