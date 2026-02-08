-module(total_appeal).
-export([total_appeal/1]).

total_appeal(S) ->
  total_appeal(S, 0, 0, []).

total_appeal([], Total, _, _) ->
  Total;
total_appeal([H|T], Total, Index, LastPositions) ->
  case lists:keyfind(H, 1, LastPositions) of
    false ->
      NewTotal = Total + (Index + 1) * (length(T) + 1),
      NewLastPositions = [{H, Index} | lists:keydelete(H, 1, LastPositions)],
      total_appeal(T, NewTotal, Index + 1, NewLastPositions);
    {_, LastIndex} ->
      NewTotal = Total + (Index - LastIndex) * (length(T) + 1),
      NewLastPositions = [{H, Index} | lists:keydelete(H, 1, LastPositions)],
      total_appeal(T, NewTotal, Index + 1, NewLastPositions)
  end.