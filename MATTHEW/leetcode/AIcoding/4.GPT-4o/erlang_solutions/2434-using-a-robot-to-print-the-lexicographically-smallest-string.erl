-module(solution).
-export([robot_with_string/1]).

robot_with_string(S) ->
    SList = string:to_list(S),
    {Result, _} = robot_with_string(SList, []),
    Result.

robot_with_string([], Acc) ->
    {lists:reverse(Acc), []};
robot_with_string([H | T], Acc) ->
    {Min, Rest} = find_min(T),
    case Min of
        none -> robot_with_string([], [H | Acc]);
        _ -> 
            NewAcc = [H | Acc],
            NewT = lists:delete(Min, T),
            robot_with_string(NewT, NewAcc)
    end.

find_min([]) -> {none, []};
find_min([H | T]) ->
    {Min, Rest} = find_min(T),
    case Min of
        none -> {H, T};
        _ -> 
            if
                H < Min -> {H, [Min | Rest]};
                true -> {Min, [H | Rest]}
            end
    end.