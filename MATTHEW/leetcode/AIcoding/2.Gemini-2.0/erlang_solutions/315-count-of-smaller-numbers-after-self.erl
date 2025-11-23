-module(count_smaller).
-export([count_smaller/1]).

count_smaller(Nums) ->
  count_smaller(Nums, [], []).

count_smaller([], _, Acc) ->
  lists:reverse(Acc);
count_smaller([H|T], Sorted, Acc) ->
  {Index, NewSorted} = insert_and_count(H, Sorted, 0),
  count_smaller(T, NewSorted, [Index|Acc]).

insert_and_count(X, [], Count) ->
  {Count, [X]};
insert_and_count(X, [H|T], Count) ->
  case X =< H of
    true ->
      {Count, [X, H|T]};
    false ->
      {Index, NewList} = insert_and_count(X, T, Count + 1),
      {Index, [H|NewList]}
  end.