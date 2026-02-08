-module(robot_print).
-export([robot_print/1]).

robot_print(S) ->
    robot_print(S, [], []).

robot_print([], Stack, Acc) ->
    lists:reverse(lists:append(lists:reverse(Stack), Acc));
robot_print([H|T], Stack, Acc) ->
    Min = lists:min([H|T]),
    case H =< Min of
        true ->
            robot_print(T, Stack, [H|Acc]);
        false ->
            case Stack of
                [] ->
                    robot_print(T, [H|Stack], Acc);
                [Top|Rest] ->
                    case Top =< Min of
                        true ->
                            robot_print(T, [H|Stack], [Top|Acc]);
                        false ->
                            robot_print([H|T], Rest, [Top|Acc])
                    end
            end
    end.