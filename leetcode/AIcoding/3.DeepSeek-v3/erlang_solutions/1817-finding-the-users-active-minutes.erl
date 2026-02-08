-spec finding_users_active_minutes(Logs :: [[integer()]], K :: integer()) -> [integer()].
finding_users_active_minutes(Logs, K) ->
    UserToMinutes = lists:foldl(fun([Id, Time], Acc) ->
        case maps:find(Id, Acc) of
            {ok, Set} -> maps:put(Id, sets:add_element(Time, Set), Acc);
            error -> maps:put(Id, sets:from_list([Time]), Acc)
        end
    end, maps:new(), Logs),
    Counts = maps:fold(fun(_Id, Set, Acc) ->
        Size = sets:size(Set),
        maps:update_with(Size, fun(V) -> V + 1 end, 1, Acc)
    end, maps:new(), UserToMinutes),
    Result = lists:map(fun(I) ->
        case maps:find(I, Counts) of
            {ok, V} -> V;
            error -> 0
        end
    end, lists:seq(1, K)),
    Result.