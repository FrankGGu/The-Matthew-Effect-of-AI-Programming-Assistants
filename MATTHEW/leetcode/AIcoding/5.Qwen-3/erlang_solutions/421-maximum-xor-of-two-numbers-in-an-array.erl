-module(max_xor).
-export([main/0]).

main() ->
    io:format("~p~n", [max_xor([3,10,5,2,7,6,1])]).

max_xor([]) -> 0;
max_xor([_]) -> 0;
max_xor(Nums) ->
    Max = lists:max(Nums),
    Trie = build_trie(Nums),
    max_xor_helper(Nums, Trie, 0).

build_trie(Nums) ->
    lists:foldl(fun(N, Acc) -> insert(Acc, N) end, [], Nums).

insert([], N) ->
    {N, [], []};
insert({Val, Left, Right}, N) ->
    Bit = (N band (1 bsl 30)) > 0,
    if
        Bit ->
            {Val, Left, insert(Right, N)};
        true ->
            {Val, insert(Left, N), Right}
    end.

max_xor_helper([], _, Acc) -> Acc;
max_xor_helper([N | Rest], Trie, Acc) ->
    Current = find_max_xor(Trie, N),
    max_xor_helper(Rest, Trie, erlang:max(Acc, Current)).

find_max_xor(_, 0) -> 0;
find_max_xor(Trie, N) ->
    find_max_xor(Trie, N, 0, 30).

find_max_xor({Val, Left, Right}, N, Result, 0) ->
    Result bxor Val;
find_max_xor({Val, Left, Right}, N, Result, Level) ->
    Bit = (N band (1 bsl Level)) > 0,
    if
        Bit ->
            case Right of
                [] -> find_max_xor(Left, N, Result, Level - 1);
                _ -> find_max_xor(Right, N, Result bxor (1 bsl Level), Level - 1)
            end;
        true ->
            case Left of
                [] -> find_max_xor(Right, N, Result, Level - 1);
                _ -> find_max_xor(Left, N, Result bxor (1 bsl Level), Level - 1)
            end
    end.