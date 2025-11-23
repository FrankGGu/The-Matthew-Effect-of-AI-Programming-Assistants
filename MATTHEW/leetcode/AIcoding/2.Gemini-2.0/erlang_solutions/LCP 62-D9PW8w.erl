-module(solution).
-export([solve/1]).

solve(routes) ->
  N = length(routes),
  Sources = lists:usort([X || Route <- routes, X <- Route]),
  SourceCount = length(Sources),

  find_hub(routes, Sources, SourceCount, 0).

find_hub(routes, Sources, SourceCount, Hub) ->
  case Hub > SourceCount of
    true ->
      -1;
    false ->
      Source = lists:nth(Hub + 1, Sources),

      IsHub = check_hub(Source, routes, SourceCount),

      case IsHub of
        true ->
          Source;
        false ->
          find_hub(routes, Sources, SourceCount, Hub + 1)
      end
  end.

check_hub(Source, routes, SourceCount) ->
  IsSource = fun(Route) ->
    lists:member(Source, Route)
  end,

  AllReach = fun(Route) ->
    lists:any(fun(X) -> X == Source end, Route)
  end,

  NumReaches = lists:sum([case AllReach(Route) of true -> 1; false -> 0 end || Route <- routes]),

  NumReaches == length(routes).