-module(solution).
-export([find_matrix/1]).

find_matrix(Nums) ->
  find_matrix(Nums, []).

find_matrix([], Acc) ->
  lists:reverse(Acc);
find_matrix(Nums, Acc) ->
  {Row, Rest} = create_row(Nums, []),
  find_matrix(Rest, [Row | Acc]).

create_row([], Acc) ->
  {lists:reverse(Acc), []};
create_row([H | T], Acc) ->
  case lists:member(H, Acc) of
    true ->
      {NewAcc, NewRest} = create_row(T, Acc),
      {NewAcc, [H | NewRest]};
    false ->
      create_row(T, [H | Acc])
  end.