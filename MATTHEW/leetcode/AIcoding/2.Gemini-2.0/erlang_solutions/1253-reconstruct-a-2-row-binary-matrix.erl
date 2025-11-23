-module(reconstruct_matrix).
-export([reconstructMatrix/3]).

reconstructMatrix(upper, lower, colsum) ->
  Len = length(colsum),
  reconstructMatrix(upper, lower, colsum, Len, [], []).

reconstructMatrix(0, 0, [], 0, U, L) ->
  lists:reverse(U),
  lists:reverse(L);
reconstructMatrix(Upper, Lower, [1 | Rest], Len, U, L) ->
  case Upper > Lower of
    true ->
      reconstructMatrix(Upper - 1, Lower, Rest, Len - 1, [1 | U], [0 | L]);
    false ->
      reconstructMatrix(Upper, Lower - 1, Rest, Len - 1, [0 | U], [1 | L])
  end;
reconstructMatrix(Upper, Lower, [2 | Rest], Len, U, L) ->
  reconstructMatrix(Upper - 1, Lower - 1, Rest, Len - 1, [1 | U], [1 | L]);
reconstructMatrix(Upper, Lower, [0 | Rest], Len, U, L) ->
  reconstructMatrix(Upper, Lower, Rest, Len - 1, [0 | U], [0 | L]);
reconstructMatrix(_, _, _, _, _, _) ->
  [].