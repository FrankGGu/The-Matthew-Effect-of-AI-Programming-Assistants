-module(solution).
-export([longest_common_subpath/2]).

longest_common_subpath(N, P) ->
    Roots = hash_tree(P, N),
    max_length(Roots, P).

hash_tree([], _) -> [].
hash_tree([H | T], N) ->
    Hash = hash(H, N),
    [Hash | hash_tree(T, N)].

hash(_, 0) -> 0;
hash(H, N) -> (H rem (10^N)) + hash(H div 10, N - 1).

max_length([], _) -> 0;
max_length([H | T], P) ->
    Max = max_length(T, P),
    case common_length(H, P) of
        Length when Length > Max -> Length;
        _ -> Max
    end.

common_length(H, []) -> 0;
common_length(H, [HP | T]) ->
    case H == HP of
        true -> 1 + common_length(H, T);
        false -> 0
    end.