-spec cycle_length_queries(N :: integer(), Queries :: [[integer()]]) -> [integer()].
cycle_length_queries(N, Queries) ->
    lists:map(fun([A, B]) -> calculate_cycle_length(A, B) end, Queries).

calculate_cycle_length(A, B) ->
    PathA = get_path(A),
    PathB = get_path(B),
    Common = find_common_length(PathA, PathB),
    length(PathA) + length(PathB) - 2 * Common + 1.

get_path(Node) ->
    get_path(Node, []).

get_path(1, Acc) -> [1 | Acc];
get_path(Node, Acc) ->
    Parent = Node div 2,
    get_path(Parent, [Node | Acc]).

find_common_length([], _) -> 0;
find_common_length(_, []) -> 0;
find_common_length([H | T1], [H | T2]) ->
    1 + find_common_length(T1, T2);
find_common_length(_, _) -> 0.