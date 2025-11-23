-module(solution).
-export([expressive_words/2]).

expressive_words(S, Words) ->
    S_Groups = group_chars(S),
    lists:foldl(fun(Word, Count) ->
        W_Groups = group_chars(Word),
        if is_expressive_match(S_Groups, W_Groups) -> Count + 1;
           true -> Count
        end
    end, 0, Words).

group_chars(String) ->
    group_chars_acc(String, [], []).

group_chars_acc([], [], Acc) ->
    lists:reverse(Acc);
group_chars_acc([], [{Char, Count}], Acc) ->
    lists:reverse([{Char, Count}|Acc]);
group_chars_acc([H|T], [], Acc) ->
    group_chars_acc(T, [{H, 1}], Acc);
group_chars_acc([H|T], [{CurrentChar, CurrentCount}], Acc) ->
    if H == CurrentChar ->
        group_chars_acc(T, [{CurrentChar, CurrentCount+1}], Acc);
    true -> % H /= CurrentChar
        group_chars_acc(T, [{H, 1}], [{CurrentChar, CurrentCount}|Acc])
    end.

is_expressive_match(S_Groups, W_Groups) ->
    is_expressive_match_loop(S_Groups, W_Groups).

is_expressive_match_loop([], []) ->
    true;
is_expressive_match_loop([{S_Char, S_Count}|S_Rest], [{W_Char, W_Count}|W_Rest]) ->
    if S_Char /= W_Char ->
        false;
    S_Count < W_Count ->
        false;
    S_Count > W_Count ->
        if S_Count < 3 ->
            false;
        true -> % S_Count >= 3
            is_expressive_match_loop(S_Rest, W_Rest)
        end;
    true -> % S_Count == W_Count
        is_expressive_match_loop(S_Rest, W_Rest)
    end;
is_expressive_match_loop(_, _) -> % One list is exhausted, the other is not, or lengths differ
    false.