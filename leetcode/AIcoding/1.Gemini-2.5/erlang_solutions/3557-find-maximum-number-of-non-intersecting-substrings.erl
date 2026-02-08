-module(solution).
-export([max_non_intersecting_substrings/1]).

-define(ALPHABET_SIZE, 26).
-define(NOT_FOUND, -1).
-define(INITIAL_FIRST, 100001).

max_non_intersecting_substrings(S) ->
    N = length(S),

    {FirstOccurrences, LastOccurrences} = build_occurrence_arrays(S, N),

    Candidates = find_candidate_substrings(S, N, FirstOccurrences, LastOccurrences),

    select_max_non_overlapping(Candidates).

build_occurrence_arrays(S, N) ->
    InitialFirst = array:new({size, ?ALPHABET_SIZE}, {default, ?INITIAL_FIRST}),
    InitialLast = array:new({size, ?ALPHABET_SIZE}, {default, ?NOT_FOUND}),

    lists:foldl(
        fun(Char, {Idx, CurrentFirst, CurrentLast}) ->
            CharIdx = Char - $a,
            NewFirst = array:set(CharIdx, min(array:get(CharIdx, CurrentFirst), Idx), CurrentFirst),
            NewLast = array:set(CharIdx, max(array:get(CharIdx, CurrentLast), Idx), CurrentLast),
            {Idx + 1, NewFirst, NewLast}
        end,
        {0, InitialFirst, InitialLast},
        S
    )
    then ({_, FinalFirst, FinalLast}) ->
        {FinalFirst, FinalLast}.

find_candidate_substrings(S, N, FirstOccurrences, LastOccurrences) ->
    find_candidate_substrings_loop(0, N, S, FirstOccurrences, LastOccurrences, []).

find_candidate_substrings_loop(I, N, S, FirstOccurrences, LastOccurrences, AccCandidates) when I < N ->
    CharI = lists:nth(I + 1, S),
    CharIdxI = CharI - $a,

    case array:get(CharIdxI, FirstOccurrences) of
        I ->
            CurrentMaxEnd = array:get(CharIdxI, LastOccurrences),
            {IsValid, FinalEnd} = check_and_extend_substring(I, I, CurrentMaxEnd, S, FirstOccurrences, LastOccurrences),

            if IsValid ->
                find_candidate_substrings_loop(I + 1, N, S, FirstOccurrences, LastOccurrences, [[FinalEnd, I] | AccCandidates]);
            true ->
                find_candidate_substrings_loop(I + 1, N, S, FirstOccurrences, LastOccurrences, AccCandidates)
            end;
        _ ->
            find_candidate_substrings_loop(I + 1, N, S, FirstOccurrences, LastOccurrences, AccCandidates)
    end;
find_candidate_substrings_loop(_I, _N, _S, _FirstOccurrences, _LastOccurrences, AccCandidates) ->
    AccCandidates.

check_and_extend_substring(I, J, CurrentMaxEnd, S, FirstOccurrences, LastOccurrences) when J =< CurrentMaxEnd ->
    CharJ = lists:nth(J + 1, S),
    CharIdxJ = CharJ - $a,

    if array:get(CharIdxJ, FirstOccurrences) < I ->
        {false, -1};
    true ->
        NewMaxEnd = max(CurrentMaxEnd, array:get(CharIdxJ, LastOccurrences)),
        check_and_extend_substring(I, J + 1, NewMaxEnd, S, FirstOccurrences, LastOccurrences)
    end;
check_and_extend_substring(_I, _J, CurrentMaxEnd, _S, _FirstOccurrences, _LastOccurrences) ->
    {true, CurrentMaxEnd}.

select_max_non_overlapping(Candidates) ->
    SortedCandidates = lists:sort(fun([E1, S1], [E2, S2]) ->
                                     if E1 < E2 -> true;
                                        E1 == E2 andalso S1 < S2 -> true;
                                        true -> false
                                     end
                                  end, Candidates),

    count_non_overlapping(SortedCandidates, ?NOT_FOUND, 0).

count_non_overlapping([], _PrevEnd, Count) ->
    Count;
count_non_overlapping([[End, Start] | Rest], PrevEnd, Count) ->
    if Start > PrevEnd ->
        count_non_overlapping(Rest, End, Count + 1);
    true ->
        count_non_overlapping(Rest, PrevEnd, Count)
    end.