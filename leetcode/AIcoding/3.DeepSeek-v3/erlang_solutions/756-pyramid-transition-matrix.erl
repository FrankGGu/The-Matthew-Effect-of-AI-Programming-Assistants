-module(solution).
-export([pyramid_transition/2]).

pyramid_transition(Bottom, Allowed) ->
    AllowedMap = lists:foldl(fun([A, B, C], Acc) ->
                                    maps:put({A, B}, [C | maps:get({A, B}, Acc, [])], Acc)
                            end, #{}, Allowed),
    pyramid(Bottom, AllowedMap).

pyramid([_], _) -> true;
pyramid(Bottom, AllowedMap) ->
    case build_next_level(Bottom, AllowedMap, [], []) of
        false -> false;
        NextLevels -> lists:any(fun(Next) -> pyramid(Next, AllowedMap) end, NextLevels)
    end.

build_next_level([_], _, _, Acc) -> [lists:reverse(Acc)];
build_next_level([A, B | Rest], AllowedMap, Temp, Acc) ->
    case maps:get({A, B}, AllowedMap, none) of
        none -> false;
        Cs -> lists:foldl(fun(C, Result) ->
                                  case Result of
                                      false -> false;
                                      _ -> build_next_level([B | Rest], AllowedMap, [C | Temp], Acc)
                                  end
                          end, true, Cs)
    end.