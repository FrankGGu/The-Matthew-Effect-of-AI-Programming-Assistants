-module(magic_dictionary).
-export([new/0, buildDict/2, search/2]).

new() ->
    [].

buildDict(_Self, WordList) ->
    WordList.

search(DictWords, SearchWord) ->
    lists:any(fun(DictWord) ->
                  is_diff_by_one(DictWord, SearchWord)
              end, DictWords).

is_diff_by_one(Word1, Word2) ->
    L1 = length(Word1),
    L2 = length(Word2),
    if
        L1 =/= L2 ->
            false;
        true ->
            % If lengths are equal, proceed to check character differences.
            % The third argument is the initial difference count.
            check_one_diff(Word1, Word2, 0)
    end.

check_one_diff([], [], 1) ->
    true; % Exactly one difference found, and both words are exhausted.
check_one_diff([], [], _DiffCount) ->
    false; % 0 or >1 differences found, and both words are exhausted.
check_one_diff([H1|T1], [H2|T2], DiffCount) ->
    NewDiffCount = if H1 =/= H2 -> DiffCount + 1; true -> DiffCount end,
    if
        NewDiffCount > 1 ->
            false; % More than one difference, so it's not a match. Stop early.
        true ->
            check_one_diff(T1, T2, NewDiffCount)
    end.