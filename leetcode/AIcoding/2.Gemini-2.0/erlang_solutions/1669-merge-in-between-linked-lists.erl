-module(merge_in_between_linked_lists).
-export([mergeInBetween/3]).

-spec mergeInBetween(List1 :: list(), A :: integer(), B :: integer(), List2 :: list()) -> list().
mergeInBetween(List1, A, B, List2) ->
    List1_arr = list_to_tuple(List1),
    List2_arr = list_to_tuple(List2),

    {Before, After} = split(List1_arr, A, B),

    case {Before, After} of
        {[], []} ->
            list_to_list(tuple_to_list(List2_arr));
        {[], End} ->
            list_to_list(tuple_to_list(List2_arr) ++ End);
        {Start, []} ->
            list_to_list(Start ++ tuple_to_list(List2_arr));
        {Start, End} ->
            list_to_list(Start ++ tuple_to_list(List2_arr) ++ End)
    end.

split(List, A, B) ->
    split_helper(list_to_list(tuple_to_list(List)), A, B, [], []).

split_helper([], _, _, Acc1, Acc2) ->
    {lists:reverse(Acc1), lists:reverse(Acc2)};
split_helper(List, A, B, Acc1, Acc2) when A > B ->
  split_helper(List, B, A, Acc1, Acc2);
split_helper([H|T], 0, B, [], Acc2) ->
    split_helper(T, 0, B-1, [H], Acc2);
split_helper([H|T], A, B, Acc1, Acc2) when A > 0 ->
    split_helper(T, A-1, B-1, Acc1 ++ [H], Acc2);
split_helper([H|T], 0, 0, Acc1, Acc2) ->
    {lists:reverse(Acc1), T};
split_helper([H|T], _, 0, Acc1, Acc2) ->
    {lists:reverse(Acc1), T}.