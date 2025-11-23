-module(solution).
-export([coprimePaths/1]).

coprimePaths(Root) ->
    Tree = build_tree(Root),
    MaxDepth = get_max_depth(Tree),
    Nodes = collect_nodes(Tree),
    PathMap = maps:from_list([{Node, []} || Node <- Nodes]),
    Result = dfs(Tree, [], PathMap, 0),
    lists:foldl(fun({Value, _}, Acc) -> Acc + Value end, 0, Result).

build_tree([]) -> [];
build_tree([Val, Left, Right]) ->
    {Val, build_tree(Left), build_tree(Right)}.

get_max_depth({_, Left, Right}) ->
    1 + max(get_max_depth(Left), get_max_depth(Right));
get_max_depth(_) -> 0.

collect_nodes({Val, Left, Right}) ->
    [Val | lists:append(collect_nodes(Left), collect_nodes(Right))];
collect_nodes(_) -> [].

dfs({Val, Left, Right}, Path, PathMap, Depth) ->
    CurrentPath = [Val | Path],
    Coprimes = find_coprimes(CurrentPath),
    Count = length(Coprimes),
    NewPathMap = maps:update(Val, CurrentPath, PathMap),
    LeftResult = case Left of
        [] -> [];
        _ -> dfs(Left, CurrentPath, NewPathMap, Depth + 1)
    end,
    RightResult = case Right of
        [] -> [];
        _ -> dfs(Right, CurrentPath, NewPathMap, Depth + 1)
    end,
    [{Count, Val} | lists:append(LeftResult, RightResult)].

find_coprimes(Path) ->
    find_coprimes(Path, []).

find_coprimes([], Acc) -> Acc;
find_coprimes([H | T], Acc) ->
    case is_coprime(H, lists:tl(Path)) of
        true -> find_coprimes(T, [H | Acc]);
        false -> find_coprimes(T, Acc)
    end.

is_coprime(X, []) -> true;
is_coprime(X, [Y | Ys]) ->
    case gcd(X, Y) of
        1 -> is_coprime(X, Ys);
        _ -> false
    end.

gcd(A, B) when A == 0 -> B;
gcd(A, B) when B == 0 -> A;
gcd(A, B) when A < B -> gcd(B, A);
gcd(A, B) -> gcd(B, A rem B).