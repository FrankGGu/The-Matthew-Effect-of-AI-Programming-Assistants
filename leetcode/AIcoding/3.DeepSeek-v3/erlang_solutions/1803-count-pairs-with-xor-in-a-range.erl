-module(solution).
-export([count_pairs/2]).

count_pairs(Nums, [Low, High]) ->
    T = build_trie(Nums),
    lists:sum([query(T, Num, High) - query(T, Num, Low - 1) || Num <- Nums]).

build_trie(Nums) ->
    lists:foldl(fun insert/2, {trie, #{}}, Nums).

insert(Num, {trie, Children}) ->
    insert(Num, {trie, Children}, 15).

insert(_, Node, -1) ->
    Node;
insert(Num, {trie, Children}, Bit) ->
    B = (Num bsr Bit) band 1,
    Child = maps:get(B, Children, {trie, #{}}),
    NewChild = insert(Num, Child, Bit - 1),
    {trie, Children#{B => NewChild}}.

query({trie, _}, _, -1) ->
    0;
query({trie, Children}, Num, Limit, Bit) ->
    B = (Num bsr Bit) band 1,
    LB = (Limit bsr Bit) band 1,
    case LB of
        1 ->
            case maps:get(1 - B, Children, {trie, #{}}) of
                {trie, _} = Child ->
                    count(Child) + query(maps:get(B, Children, {trie, #{}}), Num, Limit, Bit - 1);
                _ ->
                    query(maps:get(B, Children, {trie, #{}}), Num, Limit, Bit - 1)
            end;
        0 ->
            query(maps:get(B, Children, {trie, #{}}), Num, Limit, Bit - 1)
    end.

query(Trie, Num, Limit) ->
    query(Trie, Num, Limit, 15).

count({trie, Children}) ->
    case maps:size(Children) of
        0 -> 1;
        _ -> lists:sum([count(Child) || Child <- maps:values(Children)])
    end.