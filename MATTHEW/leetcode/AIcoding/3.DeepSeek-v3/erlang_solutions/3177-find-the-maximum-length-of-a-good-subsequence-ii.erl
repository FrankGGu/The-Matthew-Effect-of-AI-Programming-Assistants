-spec maximum_length(Nums :: [integer()], K :: integer()) -> integer().
maximum_length(Nums, K) ->
    {_, MaxLen} = lists:foldl(fun(Num, {Map, Max}) ->
        NewMap = maps:fold(fun(Key, {Len, Count}, Acc) ->
            if
                abs(Key - Num) =< K ->
                    case maps:find(Num, Acc) of
                        {ok, {OldLen, OldCount}} when OldLen < Len + 1 ->
                            maps:put(Num, {Len + 1, OldCount + Count}, Acc);
                        {ok, {OldLen, OldCount}} when OldLen =:= Len + 1 ->
                            maps:put(Num, {OldLen, OldCount + Count}, Acc);
                        error ->
                            maps:put(Num, {Len + 1, Count}, Acc);
                        _ ->
                            Acc
                    end;
                true ->
                    Acc
            end
        end, maps:new(), Map),
        case maps:find(Num, NewMap) of
            {ok, {Len, _}} when Len > Max ->
                {maps:put(Num, {1, 1}, NewMap), Len};
            _ ->
                {maps:put(Num, {1, 1}, NewMap), Max}
        end
    end, {maps:new(), 0}, Nums),
    MaxLen.