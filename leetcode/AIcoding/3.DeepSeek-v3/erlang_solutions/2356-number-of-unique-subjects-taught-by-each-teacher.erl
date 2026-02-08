-spec count_unique_subjects(Teacher :: [[integer()]]) -> [[integer()]].
count_unique_subjects(Teacher) ->
    Map = lists:foldl(fun([TeacherId, SubjectId], Acc) ->
        case maps:find(TeacherId, Acc) of
            {ok, Subjects} ->
                case sets:is_element(SubjectId, Subjects) of
                    true -> Acc;
                    false -> maps:put(TeacherId, sets:add_element(SubjectId, Subjects), Acc)
                end;
            error -> maps:put(TeacherId, sets:from_list([SubjectId]), Acc)
        end
    end, maps:new(), Teacher),
    lists:sort(fun([A, _], [B, _]) -> A =< B end,
        lists:map(fun({K, V}) -> [K, sets:size(V)] end, maps:to_list(Map))).