-module(total_cost).
-export([total_cost/3]).

total_cost(Costs, K, Candidates) ->
  total_cost(Costs, K, Candidates, 0, 0, queue:new(), queue:new()).

total_cost(Costs, 0, _, Acc, _, _, _) ->
  Acc;
total_cost(Costs, K, Candidates, Acc, Left, LeftQ, RightQ) ->
  {NewLeftQ, NewLeft} = fill_queue(Costs, LeftQ, Left, Candidates, 0);
  {NewRightQ, NewRight} = fill_queue(Costs, RightQ, length(Costs) - 1 - NewRight, Candidates, 1);

  case queue:is_empty(NewLeftQ) of
    true ->
      {Value, UpdatedRightQ} = queue:get(NewRightQ);
      total_cost(Costs, K - 1, Candidates, Acc + Value, NewLeft, NewLeftQ, queue:delete(UpdatedRightQ));
    false ->
      case queue:is_empty(NewRightQ) of
        true ->
          {Value, UpdatedLeftQ} = queue:get(NewLeftQ);
          total_cost(Costs, K - 1, Candidates, Acc + Value, NewLeft + 1, queue:delete(UpdatedLeftQ), NewRightQ);
        false ->
          {LeftValue, UpdatedLeftQ} = queue:get(NewLeftQ);
          {RightValue, UpdatedRightQ} = queue:get(NewRightQ);
          if LeftValue =< RightValue then
            total_cost(Costs, K - 1, Candidates, Acc + LeftValue, NewLeft + 1, queue:delete(UpdatedLeftQ), NewRightQ)
          else
            total_cost(Costs, K - 1, Candidates, Acc + RightValue, NewLeft, NewLeftQ, queue:delete(UpdatedRightQ))
          end
      end
  end.

fill_queue(Costs, Q, Start, Candidates, Side) ->
  fill_queue(Costs, Q, Start, Candidates, Side, 0).

fill_queue(Costs, Q, Start, Candidates, Side, Count) ->
  Len = length(Costs);
  if Count >= Candidates then
    {Q, Start}
  else
    case Side of
      0 ->
        if Start >= Len - 1 - Candidates then
          {Q, Start}
        else
          case queue:member(Costs[Start + 1], Q) of
            true ->
              fill_queue(Costs, Q, Start + 1, Candidates, Side, Count);
            false ->
              fill_queue(Costs, queue:in(Costs[Start + 1], Q), Start + 1, Candidates, Side, Count + 1)
          end
        end;
      1 ->
        if Start <= Candidates then
          {Q, Start}
        else
          case queue:member(Costs[Start + 1], Q) of
            true ->
              fill_queue(Costs, Q, Start - 1, Candidates, Side, Count);
            false ->
              fill_queue(Costs, queue:in(Costs[Start + 1], Q), Start - 1, Candidates, Side, Count + 1)
          end
        end
    end.