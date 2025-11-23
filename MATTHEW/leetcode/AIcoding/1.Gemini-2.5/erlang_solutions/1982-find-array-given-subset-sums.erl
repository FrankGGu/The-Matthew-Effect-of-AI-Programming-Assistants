-module(solution).
-export([findArray/1]).

findArray(SubsetSums) ->
    N = round(math:log2(length(SubsetSums))),
    find_array_recursive(SubsetSums, N, []).

find_array_recursive(_Sums, 0, Acc) ->
    lists:reverse(Acc);
find_array_recursive(Sums, N, Acc) ->
    SortedSums = lists:sort(Sums),
    X = lists:nth(2, SortedSums) - lists:nth(1, SortedSums),

    NextSumsForX = extract_sums(SortedSums, X),

    if
        NextSumsForX /= error andalso lists:member(0, NextSumsForX) ->
            find_array_recursive(NextSumsForX, N-1, [X | Acc]);
        true -> % If NextSumsForX is error or 0 is not in it, try -X
            NextSumsForNegX = extract_sums(SortedSums, -X),
            % This branch must succeed if a unique solution exists.
            find_array_recursive(NextSumsForNegX, N-1, [-X | Acc])
    end.

extract_sums(Sums, X) ->
    SumsMap = lists:foldl(
        fun(E, Acc) -> maps:update_with(E, fun(V) -> V + 1 end, 0, Acc) end,
        #{},
        Sums
    ),

    NextSums = [],
    CurrentSumsMap = SumsMap,
    SortedKeys = lists:sort(maps:keys(SumsMap)),

    extract_sums_loop(SortedKeys, X, CurrentSumsMap, NextSums).

extract_sums_loop([], _X, _CurrentSumsMap, NextSums) ->
    NextSums;
extract_sums_loop([S | RestKeys], X, CurrentSumsMap, AccNextSums) ->
    CountS = maps:get(S, CurrentSumsMap, 0),

    if
        CountS > 0 ->
            CountSX = maps:get(S+X, CurrentSumsMap, 0),
            if
                CountSX >= CountS -> % S is from S', so S+X is from S'+X
                    NewCurrentSumsMap = maps:update_with(S, fun(C) -> C - CountS end, 0, CurrentSumsMap),
                    NewCurrentSumsMap2 = maps:update_with(S+X, fun(C) -> C - CountS end, 0, NewCurrentSumsMap),
                    extract_sums_loop(RestKeys, X, NewCurrentSumsMap2, AccNextSums ++ lists:duplicate(CountS, S));
                true -> % S must be from S'+X, so S-X is from S'
                    CountS_minus_X = maps:get(S-X, CurrentSumsMap, 0),
                    if
                        CountS_minus_X >= CountS ->
                            NewCurrentSumsMap = maps:update_with(S, fun(C) -> C - CountS end, 0, CurrentSumsMap),
                            NewCurrentSumsMap2 = maps:update_with(S-X, fun(C) -> C - CountS end, 0, NewCurrentSumsMap),
                            extract_sums_loop(RestKeys, X, NewCurrentSumsMap2, AccNextSums ++ lists:duplicate(CountS, S-X));
                        true ->
                            error % Neither S+X nor S-X pairing works, so X is not valid
                    end
            end;
        true -> % S is already removed
            extract_sums_loop(RestKeys, X, CurrentSumsMap, AccNextSums)
    end.