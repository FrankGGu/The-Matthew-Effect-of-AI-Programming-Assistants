-module(expressive_words).
-export([expressive_words/2]).

expressive_words(S, Words) ->
    lists:foldl(fun(Word, Acc) ->
        case is_expressive(S, Word) of
            true -> Acc + 1;
            false -> Acc
        end
    end, 0, Words).

is_expressive(S, Word) ->
    is_expressive(string_to_list(S), string_to_list(Word)).

is_expressive([], []) -> true;
is_expressive([], _) -> false;
is_expressive(_, []) -> true;
is_expressive([SHead | STail], [WHead | WTail]) ->
    if SHead /= WHead ->
        false;
    true ->
        {SGroup, SRest} = group_same_chars([SHead | STail], []),
        {WGroup, WRest} = group_same_chars([WHead | WTail], []),
        SGroupLen = length(SGroup),
        WGroupLen = length(WGroup),
        if SGroupLen < WGroupLen ->
            false;
        true ->
            if SGroupLen =:= WGroupLen ->
                if SGroupLen =:= 1 ->
                   false;
                true ->
                    is_expressive(SRest, WRest)
                end;
            true ->
                if SGroupLen >= 3 ->
                    is_expressive(SRest, WRest);
                true ->
                    false
                end
            end
        end.

group_same_chars([H | T], Acc) ->
    group_same_chars(T, H, [H | Acc]);
group_same_chars([], _, Acc) ->
    {lists:reverse(Acc), []}.

group_same_chars([H | T], Char, Acc) ->
    if H =:= Char ->
        group_same_chars(T, Char, [H | Acc]);
    true ->
        {lists:reverse(Acc), [H | T]}
    end;
group_same_chars([], _, Acc) ->
    {lists:reverse(Acc), []}.