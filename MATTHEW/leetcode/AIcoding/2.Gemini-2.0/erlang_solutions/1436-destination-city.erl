-module(destination_city).
-export([dest_city/1]).

dest_city(Paths) ->
  Starts = lists:map(fun([Start, _Dest]) -> Start end, Paths),
  Dests = lists:map(fun([_Start, Dest]) -> Dest end, Paths),
  lists:foldl(fun(Dest, Acc) ->
                  case lists:member(Dest, Starts) of
                    true -> Acc;
                    false -> Dest
                  end
              end, "", Dests).