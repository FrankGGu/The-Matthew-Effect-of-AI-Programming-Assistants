-module(distribute_elements_into_two_arrays_i).
-export([distributeElements/1]).

distributeElements(nums) ->
    distributeElements(nums, [], []).

distributeElements([], A, B) ->
    {lists:reverse(A), lists:reverse(B)};
distributeElements([H|T], A, B) ->
    case length(A) == 0 orelse H >= lists:last(A) of
        true ->
            distributeElements(T, [H|A], B);
        false ->
            distributeElements(T, A, [H|B])
    end.