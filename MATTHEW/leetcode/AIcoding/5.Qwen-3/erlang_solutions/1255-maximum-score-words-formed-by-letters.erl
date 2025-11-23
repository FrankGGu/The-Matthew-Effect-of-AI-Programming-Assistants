-module(maximum_score_words_formed_by_letters).
-export([max_score/2]).

max_score(WordList, Letters) ->
    LetterCount = count_letters(Letters),
    Words = [lists:sort(W) || W <- WordList],
    max_score(Words, LetterCount, 0, 0).

max_score([], _, _, Max) -> Max;
max_score([Word | Rest], LetterCount, Index, Max) ->
    WordCount = count_letters(Word),
    if
        can_form(WordCount, LetterCount) ->
            NewLetterCount = subtract_letters(LetterCount, WordCount),
            Score = calculate_score(Word),
            NewMax = max(Max, Score + max_score(Rest, NewLetterCount, Index + 1, 0)),
            max_score(Rest, LetterCount, Index + 1, NewMax);
        true ->
            max_score(Rest, LetterCount, Index + 1, Max)
    end.

count_letters(Str) ->
    lists:foldl(fun(Char, Acc) -> dict:update_counter(Char, 1, Acc) end, dict:new(), Str).

can_form(WordCount, LetterCount) ->
    dict:fold(fun(Key, Val, Acc) -> Acc and (dict:is_key(Key, LetterCount) and (dict:fetch(Key, LetterCount) >= Val)) end, true, WordCount).

subtract_letters(LetterCount, WordCount) ->
    dict:fold(fun(Key, Val, Acc) -> dict:update_counter(Key, -Val, Acc) end, LetterCount, WordCount).

calculate_score(Word) ->
    lists:sum([score(Char) || Char <- Word]).

score($a) -> 1;
score($b) -> 3;
score($c) -> 3;
score($d) -> 2;
score($e) -> 1;
score($f) -> 4;
score($g) -> 2;
score($h) -> 4;
score($i) -> 1;
score($j) -> 8;
score($k) -> 5;
score($l) -> 1;
score($m) -> 3;
score($n) -> 1;
score($o) -> 1;
score($p) -> 3;
score($q) -> 10;
score($r) -> 1;
score($s) -> 1;
score($t) -> 1;
score($u) -> 1;
score($v) -> 4;
score($w) -> 4;
score($x) -> 8;
score($y) -> 4;
score($z) -> 10;
score(_) -> 0.