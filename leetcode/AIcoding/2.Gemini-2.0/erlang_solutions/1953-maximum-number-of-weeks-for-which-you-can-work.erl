-module(maximum_weeks).
-export([maximum_weeks/1]).

maximum_weeks(Milestones) ->
  lists:foldl(fun(X, {Sum, Max}) ->
                  {Sum + X, max(Max, X)}
              end, {0, 0}, Milestones) of
    {Sum, Max} ->
      if Max > Sum - Max then
        2 * (Sum - Max) + 1
      else
        Sum
      end
  end.