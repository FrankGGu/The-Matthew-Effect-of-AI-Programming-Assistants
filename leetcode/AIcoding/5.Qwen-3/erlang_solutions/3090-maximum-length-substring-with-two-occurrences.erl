-module(max_length_substring_with_two_occurrences).
-export([solve/1]).

solve(Str) ->
    solve(Str, 0, 0, #{}).

solve([], _Left, _Right, _) ->
    0;
solve([C | Rest], Left, Right, Count) ->
    NewCount = maps:update(C, maps:get(C, Count, 0) + 1, Count),
    case maps:get(C, NewCount) of
        2 ->
            MaxLen = Right - Left + 1,
            solve(Rest, Left, Right + 1, NewCount);
        _ ->
            if
                maps:size(NewCount) > 2 ->
                    % Move left pointer
                    LeftChar = lists:nth(Left + 1, Str),
                    NewCount2 = maps:update(LeftChar, maps:get(LeftChar, NewCount) - 1, NewCount),
                    if
                        maps:get(LeftChar, NewCount2) == 0 ->
                            NewCount3 = maps:remove(LeftChar, NewCount2);
                        true ->
                            NewCount3 = NewCount2
                    end,
                    solve(Rest, Left + 1, Right + 1, NewCount3);
                true ->
                    MaxLen = Right - Left + 1,
                    solve(Rest, Left, Right + 1, NewCount)
            end
    end.