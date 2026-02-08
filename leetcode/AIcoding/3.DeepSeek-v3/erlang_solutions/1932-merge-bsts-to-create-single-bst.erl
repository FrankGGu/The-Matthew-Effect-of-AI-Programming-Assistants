-module(solution).
-export([can_merge/1]).

can_merge(Trees) ->
    Roots = lists:foldl(fun({V, _, _}, Acc) -> sets:add_element(V, Acc) end, sets:new(), Trees),
    Leaves = lists:foldl(fun({_, L, R}, Acc) ->
                             Acc1 = case L of null -> Acc; _ -> sets:add_element(L, Acc) end,
                             case R of null -> Acc1; _ -> sets:add_element(R, Acc1) end
                         end, sets:new(), Trees),
    RootCandidates = sets:subtract(Roots, Leaves),
    case sets:size(RootCandidates) of
        1 ->
            [RootVal] = sets:to_list(RootCandidates),
            TreeMap = lists:foldl(fun({V, L, R}, Acc) -> maps:put(V, {L, R}, Acc) end, maps:new(), Trees),
            case build_bst(RootVal, TreeMap, -1, 100001) of
                {ok, _} -> true;
                _ -> false
            end;
        _ -> false
    end.

build_bst(null, _, _, _) -> {ok, null};
build_bst(Val, TreeMap, Min, Max) ->
    case Val >= Min andalso Val =< Max of
        false -> invalid;
        true ->
            case maps:find(Val, TreeMap) of
                {ok, {L, R}} ->
                    case build_bst(L, TreeMap, Min, Val - 1) of
                        {ok, Left} ->
                            case build_bst(R, TreeMap, Val + 1, Max) of
                                {ok, Right} -> {ok, {Val, Left, Right}};
                                _ -> invalid
                            end;
                        _ -> invalid
                    end;
                error -> {ok, {Val, null, null}}
            end
    end.