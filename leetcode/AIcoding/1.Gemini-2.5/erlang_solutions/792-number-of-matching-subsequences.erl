-module(solution).
-export([numMatchingSubsequences/2]).

numMatchingSubsequences(S, Words) ->
    N = length(S),
    S_tuple = list_to_tuple(S),
    NextCharPos = build_next_char_pos(S_tuple, N),
    count_matching_words(Words, NextCharPos, N).

build_next_char_pos(S_tuple, N) ->
    NextCharPos = array:new([{size, 26}, {fixed, true}]),
    InitializedNextCharPos = init_next_char_pos_arrays(NextCharPos, N, 0),
    LastPositions = array:new([{size, 26}, {fixed, true}, {default, N}]),
    build_next_char_pos_loop(N - 1, S_tuple, InitializedNextCharPos, LastPositions, N).

init_next_char_pos_arrays(AccNextCharPos, N, CharIdx) when CharIdx < 26 ->
    InnerArray = array:new([{size, N + 1}, {fixed, true}, {default, N}]),
    NewAccNextCharPos = array:set(CharIdx, InnerArray, AccNextCharPos),
    init_next_char_pos_arrays(NewAccNextCharPos, N, CharIdx + 1);
init_next_char_pos_arrays(AccNextCharPos, _N, _CharIdx) ->
    AccNextCharPos.

build_next_char_pos_loop(I, S_tuple, AccNextCharPos, AccLastPositions, N) when I >= 0 ->
    CurrentChar = element(I + 1, S_tuple),
    CurrentCharIdx = CurrentChar - $a,
    NewAccLastPositions = array:set(CurrentCharIdx, I, AccLastPositions),
    UpdatedNextCharPos = update_inner_arrays(0, I, AccNextCharPos, NewAccLastPositions, N),
    build_next_char_pos_loop(I - 1, S_tuple, UpdatedNextCharPos, NewAccLastPositions, N);
build_next_char_pos_loop(_I, _S_tuple, AccNextCharPos, _AccLastPositions, _N) ->
    AccNextCharPos.

update_inner_arrays(CharIdx, I, AccNextCharPos, LastPositions, N) when CharIdx < 26 ->
    InnerArray = array:get(CharIdx, AccNextCharPos),
    LastPosForThisChar = array:get(CharIdx, LastPositions),
    NewInnerArray = array:set(I, LastPosForThisChar, InnerArray),
    NewAccNextCharPos = array:set(CharIdx, NewInnerArray, AccNextCharPos),
    update_inner_arrays(CharIdx + 1, I, NewAccNextCharPos, LastPositions, N);
update_inner_arrays(_CharIdx, _I, AccNextCharPos, _LastPositions, _N) ->
    AccNextCharPos.

count_matching_words(Words, NextCharPos, N) ->
    lists:foldl(fun(Word, Count) ->
        case is_subsequence(Word, NextCharPos, N) of
            true -> Count + 1;
            false -> Count
        end
    end, 0, Words).

is_subsequence(Word, NextCharPos, N) ->
    is_subsequence_loop(Word, 0, NextCharPos, N).

is_subsequence_loop([], _CurrentSIdx, _NextCharPos, _N) ->
    true;
is_subsequence_loop([Char | Rest], CurrentSIdx, NextCharPos, N) ->
    CharIdx = Char - $a,
    InnerArray = array:get(CharIdx, NextCharPos),
    NextOccurIdx = array:get(CurrentSIdx, InnerArray),

    if NextOccurIdx == N ->
        false;
    true ->
        is_subsequence_loop(Rest, NextOccurIdx + 1, NextCharPos, N)
    end.