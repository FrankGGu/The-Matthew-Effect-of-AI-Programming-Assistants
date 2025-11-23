-module(solution).
-export([maximize_xor/2]).

maximize_xor(Nums, Queries) ->
    Trie = build_trie(Nums),
    lists:map(fun({X, M}) -> query_trie(Trie, X, M) end, Queries).

build_trie(Nums) ->
    lists:foldl(fun insert_num/2, {trie, #{}}, Nums).

insert_num(Num, {trie, Node}) ->
    insert_num(Num, 30, {trie, Node}).

insert_num(_, -1, {trie, Node}) ->
    {trie, Node};
insert_num(Num, Bit, {trie, Node}) ->
    B = (Num bsr Bit) band 1,
    Child = maps:get(B, Node, {trie, #{}}),
    {trie, NewChild} = insert_num(Num, Bit - 1, Child),
    {trie, Node#{B => NewChild}}.

query_trie({trie, _}, _, M) when M < 0 -> -1;
query_trie(Trie, X, M) ->
    case query_trie(Trie, X, M, 30, 0) of
        not_found -> -1;
        Res -> Res bxor X
    end.

query_trie(_, _, _, -1, Num) -> Num;
query_trie({trie, Node}, X, M, Bit, Num) ->
    B = (X bsr Bit) band 1,
    Desired = 1 - B,
    case maps:get(Desired, Node, not_found) of
        not_found ->
            case maps:get(B, Node, not_found) of
                not_found -> not_found;
                Child -> query_trie(Child, X, M, Bit - 1, Num)
            end;
        {trie, _} = Child ->
            Candidate = Num bor (Desired bsl Bit),
            if
                Candidate =< M -> query_trie(Child, X, M, Bit - 1, Candidate);
                true ->
                    case maps:get(B, Node, not_found) of
                        not_found -> not_found;
                        ChildB -> query_trie(ChildB, X, M, Bit - 1, Num bor (B bsl Bit))
                    end
            end
    end.