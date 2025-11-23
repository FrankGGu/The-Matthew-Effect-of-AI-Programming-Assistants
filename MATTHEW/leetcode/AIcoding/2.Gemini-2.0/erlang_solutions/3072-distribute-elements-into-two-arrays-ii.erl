-module(distribute_elements_into_two_arrays_ii).
-export([distribute_elements/1]).

distribute_elements(nums) ->
  distribute_elements(nums, [], []).

distribute_elements([], a, b) ->
  {lists:reverse(a), lists:reverse(b)};
distribute_elements([H|T], A, B) ->
  LA = length(A),
  LB = length(B),
  case {LA > 0 andalso H >= lists:nth(0, A), LB > 0 andalso H >= lists:nth(0, B)} of
    {true, true} ->
      case lists:nth(0, A) > lists:nth(0, B) of
        true -> distribute_elements(T, [H|A], B);
        false -> distribute_elements(T, A, [H|B])
      end;
    {true, false} ->
      distribute_elements(T, [H|A], B);
    {false, true} ->
      distribute_elements(T, A, [H|B]);
    {false, false} ->
      distribute_elements(T, [H|A], B)
  end.