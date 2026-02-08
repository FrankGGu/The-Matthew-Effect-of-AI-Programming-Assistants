-module(solution).
-export([repeated_substring_pattern/1]).

-spec repeated_substring_pattern(unicode:unicode_binary()) -> boolean().
repeated_substring_pattern(S) ->
    Len = length(S),
    lists:foreach(fun(L) -> 
                      case Len rem L of
                          0 -> 
                              Sub = lists:sublist(S, 1, L),
                              Repeated = lists:duplicate(Len div L, Sub),
                              if lists:flatten(Repeated) =:= S -> throw(true);
                              true -> ok
                          end
                  end, lists:seq(1, Len div 2)),
    false.
