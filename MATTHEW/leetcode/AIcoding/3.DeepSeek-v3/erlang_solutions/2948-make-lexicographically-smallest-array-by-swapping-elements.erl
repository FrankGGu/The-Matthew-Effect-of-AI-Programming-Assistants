-spec smallest_lex_array(Nums :: [integer()], Limit :: integer()) -> [integer()].
smallest_lex_array(Nums, Limit) ->
    N = length(Nums),
    Indices = lists:seq(0, N - 1),
    SortedIndices = lists:sort(fun(I, J) -> lists:nth(I + 1, Nums) =< lists:nth(J + 1, Nums) end, Indices),
    Groups = group_indices(SortedIndices, Nums, Limit, []),
    Grouped = assign_groups(Groups, N),
    Result = lists:map(fun(Group) ->
        SortedGroup = lists:sort(fun(I, J) -> lists:nth(I + 1, Nums) =< lists:nth(J + 1, Nums) end, Group),
        Values = lists:map(fun(I) -> lists:nth(I + 1, Nums) end, SortedGroup),
        lists:zip(SortedGroup, Values)
    end, Grouped),
    Merged = lists:flatten(Result),
    SortedMerged = lists:sort(fun({I, _}, {J, _}) -> I =< J end, Merged),
    lists:map(fun({_, Val}) -> Val end, SortedMerged).

group_indices([], _, _, Acc) ->
    lists:reverse(Acc);
group_indices([I | Rest], Nums, Limit, []) ->
    group_indices(Rest, Nums, Limit, [[I]]);
group_indices([I | Rest], Nums, Limit, [Group | Groups]) ->
    Last = hd(Group),
    if
        lists:nth(I + 1, Nums) - lists:nth(Last + 1, Nums) =< Limit ->
            group_indices(Rest, Nums, Limit, [[I | Group] | Groups]);
        true ->
            group_indices(Rest, Nums, Limit, [[I] | [Group | Groups]])
    end.

assign_groups(Groups, N) ->
    GroupMap = assign_groups(Groups, #{}, 0),
    lists:foldl(fun(I, Acc) ->
        Group = maps:get(I, GroupMap),
        case Acc of
            [] -> [[I]];
            _ ->
                case lists:last(Acc) of
                    [H | _] when maps:get(H, GroupMap) =:= Group ->
                        [lists:append(lists:last(Acc), [I]) | lists:droplast(Acc)];
                    _ -> [[I] | Acc]
                end
        end
    end, [], lists:seq(0, N - 1)).

assign_groups([], Map, _) -> Map;
assign_groups([Group | Rest], Map, GroupId) ->
    NewMap = lists:foldl(fun(I, M) -> M#{I => GroupId} end, Map, Group),
    assign_groups(Rest, NewMap, GroupId + 1).