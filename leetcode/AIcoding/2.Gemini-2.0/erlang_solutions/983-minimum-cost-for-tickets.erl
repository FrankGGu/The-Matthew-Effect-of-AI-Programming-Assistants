-module(minimum_cost_tickets).
-export([mincostTickets/2]).

mincostTickets(Days, Costs) ->
  mincostTickets(Days, Costs, []).

mincostTickets(Days, Costs, Memo) ->
  case lists:member(Days, Memo) of
    true ->
      proplists:get_value(Days, Memo);
    false ->
      case Days of
        [] ->
          0;
        [Day | Rest] ->
          Cost1 = element(1, Costs) + mincostTickets(Rest, Costs, Memo),
          Cost7 = element(2, Costs) + mincostTickets(remove_days(Rest, Day, 7), Costs, Memo),
          Cost30 = element(3, Costs) + mincostTickets(remove_days(Rest, Day, 30), Costs, Memo),
          MinCost = min(min(Cost1, Cost7), Cost30),
          NewMemo = [{Days, MinCost} | Memo],
          MinCost
      end
  end.

remove_days(Days, StartDay, Duration) ->
  lists:filter(fun(Day) -> Day > StartDay + Duration - 1 end, Days).