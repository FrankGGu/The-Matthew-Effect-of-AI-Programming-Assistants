-module(count_hidden_sequences).
-export([number_of_arithmetic_sequences/3]).

number_of_arithmetic_sequences(N, Lower, Upper, Differences) ->
  number_of_arithmetic_sequences_helper(N, Lower, Upper, Differences, 0, 0).

number_of_arithmetic_sequences_helper(N, Lower, Upper, [H|T], Current, Min) ->
  Next = Current + H,
  NewMin = min(Min, Next),
  number_of_arithmetic_sequences_helper(N, Lower, Upper, T, Next, NewMin);
number_of_arithmetic_sequences_helper(N, Lower, Upper, [], Current, Min) ->
  Range = Upper - Lower + 1,
  Diff = Current - Min,
  max(0, Range - N + 1 - Diff).