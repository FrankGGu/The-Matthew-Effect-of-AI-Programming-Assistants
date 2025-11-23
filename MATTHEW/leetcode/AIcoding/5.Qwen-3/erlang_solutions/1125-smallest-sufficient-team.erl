-module(small_sufficient_team).
-export([find_geek_team/2]).

find_geek_team(need, have) ->
    Map = maps:from_list(have),
    Length = length(need),
    Solution = find_solution(need, Map, 0, Length, []),
    lists:reverse(Solution).

find_solution([], _, _, _, Acc) ->
    Acc;
find_solution(Need, Map, Index, Length, Acc) ->
    Case = case Index of
        Length -> 
            [];
        _ ->
            Key = lists:nth(Index + 1, Need),
            Values = maps:get(Key, Map, []),
            find_sub_solution(Need, Map, Index, Length, Acc, Values, [])
    end,
    Case.

find_sub_solution(_, _, _, Length, Acc, [], _) ->
    if
        Length == 0 -> Acc;
        true -> find_solution(Need, Map, Index + 1, Length, Acc)
    end;
find_sub_solution(Need, Map, Index, Length, Acc, [H | T], Temp) ->
    NewAcc = [H | Acc],
    NewNeed = subtract_need(Need, H),
    NewLength = length(NewNeed),
    Result = find_solution(NewNeed, Map, Index + 1, NewLength, NewAcc),
    if
        Result /= [] -> Result;
        true -> find_sub_solution(Need, Map, Index, Length, Acc, T, Temp)
    end.

subtract_need(Need, Skills) ->
    lists:foldl(fun(Skill, Acc) ->
        case lists:member(Skill, Acc) of
            true -> lists:delete(Skill, Acc);
            false -> Acc
        end
    end, Need, Skills).