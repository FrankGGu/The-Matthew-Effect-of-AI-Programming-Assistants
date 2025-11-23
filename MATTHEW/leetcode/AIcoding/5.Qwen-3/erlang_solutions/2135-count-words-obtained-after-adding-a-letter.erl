-module(solution).
-export([count_words/2]).

count_words(Start, Target) ->
    Count = 0,
    Words = lists:usort(Start),
    count_words(Words, Target, Count).

count_words([], _, Count) ->
    Count;
count_words([Word | Rest], Target, Count) ->
    case is_valid(Word, Target) of
        true ->
            count_words(Rest, Target, Count + 1);
        false ->
            count_words(Rest, Target, Count)
    end.

is_valid(Word, Target) ->
    WordLength = length(Word),
    TargetLength = length(Target),
    WordLength + 1 == TargetLength andalso
    is_subsequence(Word, Target).

is_subsequence([], _) ->
    true;
is_subsequence(_, []) ->
    false;
is_subsequence([H | T], [H | T2]) ->
    is_subsequence(T, T2);
is_subsequence([H | T], [H2 | T2]) ->
    is_subsequence([H | T], T2).