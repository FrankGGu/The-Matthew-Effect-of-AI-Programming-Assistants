-module(solution).
-export([is_solvable/3]).

is_solvable(Words, Result) ->
    AllWords = Words ++ [Result],
    UniqueChars = lists:usort(lists:concat(AllWords)),
    FirstChars = [hd(Word) || Word <- AllWords, length(Word) > 1],
    UniqueFirstChars = lists:usort(FirstChars),
    MaxLen = lists:max([length(W) || W <- AllWords]),
    if
        length(UniqueChars) > 10 -> false;
        MaxLen < length(Result) -> false;
        true -> backtrack(UniqueChars, UniqueFirstChars, Words, Result, #{}, 0, lists:duplicate(10, false))
    end.

backtrack([], _, Words, Result, Map, _, _) ->
    Sum = lists:sum([word_to_num(Word, Map) || Word <- Words]),
    Sum =:= word_to_num(Result, Map);
backtrack([Char|Rest], FirstChars, Words, Result, Map, Pos, Used) ->
    MaxDigit = case lists:member(Char, FirstChars) of
                   true -> 9;
                   false -> 9
               end,
    MinDigit = case lists:member(Char, FirstChars) of
                   true -> 1;
                   false -> 0
               end,
    try_digits(MinDigit, MaxDigit, Char, Rest, FirstChars, Words, Result, Map, Pos, Used).

try_digits(Digit, MaxDigit, _, _, _, _, _, _, _, _) when Digit > MaxDigit ->
    false;
try_digits(Digit, MaxDigit, Char, Rest, FirstChars, Words, Result, Map, Pos, Used) ->
    case lists:nth(Digit + 1, Used) of
        true ->
            try_digits(Digit + 1, MaxDigit, Char, Rest, FirstChars, Words, Result, Map, Pos, Used);
        false ->
            NewMap = maps:put(Char, Digit, Map),
            NewUsed = setnth(Digit + 1, true, Used),
            case backtrack(Rest, FirstChars, Words, Result, NewMap, Pos, NewUsed) of
                true -> true;
                false -> try_digits(Digit + 1, MaxDigit, Char, Rest, FirstChars, Words, Result, Map, Pos, Used)
            end
    end.

word_to_num(Word, Map) ->
    lists:foldl(fun(C, Acc) -> Acc * 10 + maps:get(C, Map) end, 0, Word).

setnth(1, Val, [_|T]) -> [Val|T];
setnth(N, Val, [H|T]) -> [H|setnth(N-1, Val, T)].