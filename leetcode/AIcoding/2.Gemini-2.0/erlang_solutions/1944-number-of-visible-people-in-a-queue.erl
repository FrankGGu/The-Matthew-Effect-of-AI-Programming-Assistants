-module(visible_people).
-export([can_see_persons_count/1]).

can_see_persons_count(Heights) ->
  can_see_persons_count(Heights, []).

can_see_persons_count([], Acc) ->
  lists:reverse(Acc);
can_see_persons_count([H|T], Acc) ->
  {Visible, Stack} = process_height(H, []),
  {VisibleCount, NewStack} = can_see_persons_count(T, Stack, 0, Visible, []),
  can_see_persons_count(T, [Visible + VisibleCount | Acc], [], Visible, []).

can_see_persons_count([], Stack, VisibleCount, Visible, Acc) ->
  {VisibleCount, lists:reverse(Acc)};
can_see_persons_count([H|T], Stack, VisibleCount, Visible, Acc) ->
  {NewVisible, NewStack} = process_height(H, Stack),
  {NewVisibleCount, NewNewStack} = can_see_persons_count(T, NewStack, 0, NewVisible, []),
  can_see_persons_count(T, [Visible + VisibleCount + NewVisible + NewVisibleCount | Acc], [], NewVisible, []).

process_height(H, []) ->
  {0, [H]};
process_height(H, [Top|Rest]) when H > Top ->
  {1, process_height(H, Rest)};
process_height(H, [Top|Rest]) ->
  {0, [Top, H]};

process_height(H, List) ->
  process_height_helper(H, List, 0).

process_height_helper(H, [], Count) ->
  {Count, [H]};
process_height_helper(H, [Top|Rest], Count) when H > Top ->
  process_height_helper(H, Rest, Count + 1);
process_height_helper(H, [Top|Rest], Count) ->
  {Count, [Top, H]}.