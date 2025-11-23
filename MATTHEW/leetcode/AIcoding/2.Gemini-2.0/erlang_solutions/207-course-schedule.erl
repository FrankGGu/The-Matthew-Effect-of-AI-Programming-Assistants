-module(course_schedule).
-export([can_finish/2]).

can_finish(NumCourses, Prerequisites) ->
    Graph = create_graph(NumCourses, Prerequisites),
    Visited = lists:seq(1, NumCourses),
    can_finish_helper(Graph, Visited, []).

create_graph(NumCourses, Prerequisites) ->
    lists:foldl(fun({Course, Pre}, Acc) ->
                        case maps:is_key(Pre, Acc) of
                            true ->
                                maps:update(Pre, [Course | maps:get(Pre, Acc)], Acc);
                            false ->
                                maps:put(Pre, [Course], Acc)
                        end
                end, maps:new(), Prerequisites).

can_finish_helper(Graph, [Course | Rest], Visiting) ->
    case lists:member(Course, Visiting) of
        true ->
            false;
        false ->
            case maps:is_key(Course, Graph) of
                true ->
                    NextCourses = maps:get(Course, Graph),
                    case lists:all(fun(NextCourse) ->
                                           can_finish_helper(Graph, [NextCourse], [Course | Visiting])
                                   end, NextCourses) of
                        true ->
                            can_finish_helper(Graph, Rest, lists:delete(Course, Visiting));
                        false ->
                            false
                    end;
                false ->
                    can_finish_helper(Graph, Rest, lists:delete(Course, Visiting))
            end
    end;
can_finish_helper(_, [], _) ->
    true.