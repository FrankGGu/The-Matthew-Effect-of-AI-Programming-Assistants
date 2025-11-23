-module(largest_merge_of_two_strings).
-export([merge_similar/2]).

merge_similar(A, B) ->
    merge(A, B, []).

merge([], B, Acc) ->
    lists:reverse(Acc ++ B);
merge(A, [], Acc) ->
    lists:reverse(Acc ++ A);
merge(A, B, Acc) ->
    case compare(A, B) of
        true -> merge(tl(A), B, [hd(A) | Acc]);
        false -> merge(A, tl(B), [hd(B) | Acc])
    end.

compare([], _) ->
    true;
compare(_, []) ->
    false;
compare([H1 | T1], [H2 | T2]) ->
    if
        H1 > H2 -> true;
        H1 < H2 -> false;
        true -> compare(T1, T2)
    end.