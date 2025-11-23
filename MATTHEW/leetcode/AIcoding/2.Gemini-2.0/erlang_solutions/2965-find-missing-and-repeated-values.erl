-module(find_missing_repeated_values).
-export([find_missing_repeated_values/1]).

find_missing_repeated_values(Grid) ->
  N = length(hd(Grid)),
  Size = N * N,
  {Repeated, Missing} = find_missing_repeated_values_helper(Grid, Size),
  [Repeated, Missing].

find_missing_repeated_values_helper(Grid, Size) ->
  List = lists:flatten(Grid),
  Counts = lists:foldl(fun(X, Acc) ->
                          maps:update_with(X, fun(Count) -> Count + 1 end, 1, Acc)
                        end, #{}, List),
  Repeated = lists:keyfind(2, 2, maps:to_list(Counts)),
  RepeatedVal = case Repeated of
                  {Key, _} -> Key;
                  false -> 0 % Should not happen according to problem description
                end,

  SumList = lists:sum(List),
  SumN = (Size * (Size + 1)) div 2,
  Missing = RepeatedVal + SumN - SumList,
  {RepeatedVal, Missing}.