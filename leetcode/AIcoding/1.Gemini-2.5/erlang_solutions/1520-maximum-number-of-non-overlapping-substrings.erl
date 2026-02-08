-module(solution).
-export([max_num_non_overlapping_substrings/1]).

max_num_non_overlapping_substrings(S) ->
    N = length(S),
    {FirstOcc, LastOcc} = precompute_occurrences(S, N),
    Candidates = find_candidates_optimized(S, N, FirstOcc, LastOcc),
    select_non_overlapping(Candidates, S).

precompute_occurrences(S, N) ->
    InitialFirstOcc = lists:duplicate(26, N),
    InitialLastOcc = lists:duplicate(26, -1),
    precompute_occurrences_loop(S, 0, InitialFirstOcc, InitialLastOcc).

precompute_occurrences_loop([], _Idx, FirstOcc, LastOcc) ->
    {FirstOcc, LastOcc};
precompute_occurrences_loop([Char | Rest], Idx, FirstOcc, LastOcc) ->
    CharIdx = Char - $a,
    CurrentFirst = lists:nth(CharIdx + 1, FirstOcc),
    CurrentLast = lists:nth(CharIdx + 1, LastOcc),
    NewFirstOcc = lists:replace_nth(CharIdx + 1, min(CurrentFirst, Idx), FirstOcc),
    NewLastOcc = lists:replace_nth(CharIdx + 1, max(CurrentLast, Idx), LastOcc),
    precompute_occurrences_loop(Rest, Idx + 1, NewFirstOcc, NewLastOcc).

find_candidates_optimized(S, N, FirstOcc, LastOcc) ->
    find_candidates_optimized_loop(0, N, S, FirstOcc, LastOcc, []).

find_candidates_optimized_loop(I, N, S, FirstOcc, LastOcc, AccCandidates) when I < N ->
    CharI = lists:nth(I + 1, S),
    CharIdxI = CharI - $a,

    CurrentMaxEnd = lists:nth(CharIdxI + 1, LastOcc),

    {IsValidStart, FinalEnd, NextI} = expand_and_check(I, CurrentMaxEnd, S, FirstOcc, LastOcc),

    NewAccCandidates =
        if IsValidStart ->
            [{I, FinalEnd} | AccCandidates];
        else ->
            AccCandidates
        end,
    find_candidates_optimized_loop(NextI, N, S, FirstOcc, LastOcc, NewAccCandidates);
find_candidates_optimized_loop(_I, _N, _S, _FirstOcc, _LastOcc, AccCandidates) ->
    AccCandidates.

expand_and_check(OriginalI, InitialMaxEnd, S, FirstOcc, LastOcc) ->
    expand_and_check_loop(OriginalI, InitialMaxEnd, S, FirstOcc, LastOcc, OriginalI).

expand_and_check_loop(K, CurrentMaxEnd, S, FirstOcc, LastOcc, OriginalI) when K =< CurrentMaxEnd ->
    CharK = lists:nth(K + 1, S),
    CharIdxK = CharK - $a,
    CharKFirstOcc = lists:nth(CharIdxK + 1, FirstOcc),
    CharKLastOcc = lists:nth(CharIdxK + 1, LastOcc),

    if CharKFirstOcc < OriginalI ->
        {false, -1, OriginalI + 1};
    else ->
        NewMaxEnd = max(CurrentMaxEnd, CharKLastOcc),
        expand_and_check_loop(K + 1, NewMaxEnd, S, FirstOcc, LastOcc, OriginalI)
    end;
expand_and_check_loop(_K, CurrentMaxEnd, _S, _FirstOcc, _LastOcc, _OriginalI) ->
    {true, CurrentMaxEnd, CurrentMaxEnd + 1}.

select_non_overlapping(Candidates, S) ->
    SortedCandidates = lists:sort(fun({S1, E1}, {S2, E2}) ->
                                          if E1 =/= E2 -> E1 < E2;
                                             true -> (E1 - S1) < (E2 - S2)
                                          end
                                  end, Candidates),
    select_loop(SortedCandidates, -1, S, []).

select_loop([], _LastEnd, _S, AccResult) ->
    lists:reverse(AccResult);
select_loop([{Start, End} | Rest], LastEnd, S, AccResult) ->
    if Start > LastEnd ->
        Substring = lists:sublist(S, Start + 1, End - Start + 1),
        select_loop(Rest, End, S, [Substring | AccResult]);
    else ->
        select_loop(Rest, LastEnd, S, AccResult)
    end.