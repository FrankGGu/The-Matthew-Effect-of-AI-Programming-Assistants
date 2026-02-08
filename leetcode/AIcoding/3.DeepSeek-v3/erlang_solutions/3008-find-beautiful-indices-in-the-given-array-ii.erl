-module(solution).
-export([beautiful_indices/3]).

beautiful_indices(S, A, B) ->
    N = length(S),
    PrefixA = build_prefix(S, A),
    PrefixB = build_prefix(S, B),
    IndicesA = find_indices(PrefixA, length(A)),
    IndicesB = find_indices(PrefixB, length(B)),
    Beautiful = lists:foldl(
        fun(I, Acc) ->
            case lists:any(fun(J) -> abs(I - J) =< B end, IndicesB) of
                true -> [I | Acc];
                false -> Acc
            end
        end,
        [],
        IndicesA
    ),
    lists:sort(Beautiful).

build_prefix(S, Pattern) ->
    M = length(Pattern),
    N = length(S),
    Prefix = lists:duplicate(M + N + 1, 0),
    build_prefix(S, Pattern, Prefix, 0, 1).

build_prefix(_, [], Prefix, _, _) -> Prefix;
build_prefix(S, [P | Pt], Prefix, Len, I) ->
    NewLen = case I > 1 andalso Len > 0 andalso lists:nth(I - 1, S) =/= P of
        true -> lists:nth(Len, Prefix);
        false -> Len
    end,
    NewLen1 = case lists:nth(I, S) =:= P of
        true -> NewLen + 1;
        false -> NewLen
    end,
    NewPrefix = set_nth(I + 1, NewLen1, Prefix),
    build_prefix(S, Pt, NewPrefix, NewLen1, I + 1).

find_indices(Prefix, M) ->
    N = length(Prefix) - 1,
    find_indices(Prefix, M, N, 1, []).

find_indices(_, _, N, I, Acc) when I > N -> lists:reverse(Acc);
find_indices(Prefix, M, N, I, Acc) ->
    case lists:nth(I + 1, Prefix) =:= M of
        true -> find_indices(Prefix, M, N, I + 1, [I - M | Acc]);
        false -> find_indices(Prefix, M, N, I + 1, Acc)
    end.

set_nth(1, Val, [_ | T]) -> [Val | T];
set_nth(N, Val, [H | T]) -> [H | set_nth(N - 1, Val, T)].