-module(steps_to_make_array_non_decreasing).
-export([steps_to_make_array_non_decreasing/1]).

steps_to_make_array_non_decreasing(Nums) ->
    steps_to_make_array_non_decreasing(Nums, []).

steps_to_make_array_non_decreasing([], Stack) ->
    0;
steps_to_make_array_non_decreasing([H|T], Stack) ->
    {Steps, NewStack} = process_element(H, Stack, 0),
    max(Steps, steps_to_make_array_non_decreasing(T, NewStack)).

process_element(H, Stack, MaxSteps) ->
    process_element(H, Stack, MaxSteps, []).

process_element(H, [], MaxSteps, Acc) ->
    {MaxSteps, [{H, 0} | Acc]};
process_element(H, [{Val, Steps} | Rest], MaxSteps, Acc) when H >= Val ->
    {MaxSteps, [{H, 0} | lists:reverse([{Val, Steps} | Rest]) ++ lists:reverse(Acc)]};
process_element(H, [{Val, Steps} | Rest], MaxSteps, Acc) ->
    process_element(H, Rest, max(MaxSteps, Steps + 1), [{Val, Steps} | Acc]).