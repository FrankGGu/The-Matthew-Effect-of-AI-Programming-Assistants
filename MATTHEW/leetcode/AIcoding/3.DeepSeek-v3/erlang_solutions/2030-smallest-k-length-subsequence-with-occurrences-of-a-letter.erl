-module(solution).
-export([smallest_subsequence/3]).

smallest_subsequence(S, K, Letter) ->
    {S1, Count} = process_string(S, Letter),
    N = length(S1),
    Stack = [],
    {Result, _} = build_subsequence(S1, Stack, 0, N, K, Letter, Count),
    Result.

process_string(S, Letter) ->
    process_string(S, Letter, [], 0).

process_string([], _, Acc, Count) ->
    {lists:reverse(Acc), Count};
process_string([C | Rest], Letter, Acc, Count) when C =:= Letter ->
    process_string(Rest, Letter, [C | Acc], Count + 1);
process_string([C | Rest], Letter, Acc, Count) ->
    process_string(Rest, Letter, [C | Acc], Count).

build_subsequence(_, Stack, _, _, 0, _, _) ->
    {lists:reverse(Stack), 0};
build_subsequence([], Stack, Removed, _, K, Letter, Count) ->
    {lists:reverse(Stack) ++ lists:nthtail(Removed, lists:duplicate(K - length(Stack), $a)), 0};
build_subsequence([C | Rest], Stack, Removed, N, K, Letter, Count) ->
    case Stack of
        [] ->
            build_subsequence(Rest, [C | Stack], Removed, N - 1, K - 1, Letter, Count - if C =:= Letter -> 1; true -> 0 end);
        [Top | _] ->
            case (C < Top) andalso (length(Stack) + N - 1 >= K) andalso ((Top =/= Letter) orelse (Count > (K - length(Stack)))) of
                true ->
                    NewCount = if Top =:= Letter -> Count - 1; true -> Count end,
                    build_subsequence([C | Rest], tl(Stack), Removed + 1, N, K, Letter, NewCount);
                false ->
                    case length(Stack) < K of
                        true ->
                            NewCount = if C =:= Letter -> Count - 1; true -> Count end,
                            build_subsequence(Rest, [C | Stack], Removed, N - 1, K, Letter, NewCount);
                        false ->
                            build_subsequence(Rest, Stack, Removed + 1, N - 1, K, Letter, Count - if C =:= Letter -> 1; true -> 0 end)
                    end
            end
    end.