-module(shortest_palindrome).
-export([shortest_palindrome/1]).

shortest_palindrome(S) ->
    Len = length(S),
    case Len of
        0 -> "";
        _ ->
            {T, RevT} = prepare_string(S),
            NewS = T ++ "#" ++ RevT,
            LPS = kmp_table(NewS),
            PrefixLen = lists:last(LPS),
            Suffix = lists:sublist(S, PrefixLen + 1, Len - PrefixLen),
            lists:reverse(Suffix) ++ S
    end.

prepare_string(S) ->
    {S, lists:reverse(S)}.

kmp_table(W) ->
    N = length(W),
    kmp_table_aux(W, N, 0, 1, []).

kmp_table_aux(_W, 0, _Len, _I, Acc) ->
    lists:reverse(Acc);
kmp_table_aux(W, N, Len, I, Acc) ->
    case element(I, string:explode(W)) =:= element(Len + 1, string:explode(W)) of
        true ->
            kmp_table_aux(W, N, Len + 1, I + 1, [Len + 1 | Acc]);
        false ->
            case Len of
                0 ->
                    kmp_table_aux(W, N, Len, I + 1, [0 | Acc]);
                _ ->
                    NewLen = element(Len + 1, kmp_table(lists:sublist(W, 1, Len))),
                    kmp_table_aux(W, N, NewLen, I, Acc)
            end
    end.