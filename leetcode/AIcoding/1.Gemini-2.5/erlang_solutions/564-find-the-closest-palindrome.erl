-module(solution).
-export([nearest_palindromic/1]).

nearest_palindromic(N_str) ->
    N_int = list_to_integer(N_str),
    Len = string:len(N_str),
    IsOdd = (Len rem 2 == 1),
    HalfLen = (Len + 1) div 2,
    PrefixStr = string:substr(N_str, 1, HalfLen),
    PrefixInt = list_to_integer(PrefixStr),

    Candidates = generate_candidates(Len, PrefixInt, IsOdd),

    find_closest(lists:filter(fun(X) -> X /= N_int end, Candidates), N_int).

generate_candidates(Len, PrefixInt, IsOdd) ->
    % Special candidates: all 9s (length Len-1) and 10...01 (length Len+1)
    SpecialCandidates = 
        [
            (if Len > 1 -> list_to_integer(lists:duplicate(Len - 1, $9)); else 0 end),
            list_to_integer("1" ++ lists:duplicate(Len - 1, $0) ++ "1")
        ],

    % Candidates from PrefixInt variations
    PrefixVariations = [-1, 0, 1],
    PrefixBasedCandidates = 
        lists:foldl(fun(Offset, Acc) ->
            CurrentPrefixInt = PrefixInt + Offset,
            if CurrentPrefixInt =< 0 -> % Skip if prefix becomes 0 or negative
                Acc;
            true ->
                CurrentPrefixStr = integer_to_string(CurrentPrefixInt),
                P_len = string:len(CurrentPrefixStr),
                SuffixLen = P_len - (if IsOdd -> 1; else 0 end),
                Suffix = lists:reverse(string:substr(CurrentPrefixStr, 1, SuffixLen)),
                Pal_val = list_to_integer(CurrentPrefixStr ++ Suffix),
                [Pal_val | Acc]
            end
        end, [], PrefixVariations),

    AllCandidates = lists:usort(SpecialCandidates ++ PrefixBasedCandidates),
    lists:filter(fun(X) -> X > 0 end, AllCandidates). % Filter out any 0s generated (e.g., from Len=1 all 9s case)

find_closest(Candidates, N_int) ->
    find_closest_recursive(Candidates, N_int, float:infinity(), 0).

find_closest_recursive([], _N_int, _MinDiff, Result) ->
    integer_to_string(Result);
find_closest_recursive([Cand | Rest], N_int, MinDiff, CurrentResult) ->
    Diff = abs(Cand - N_int),
    if Diff < MinDiff ->
        find_closest_recursive(Rest, N_int, Diff, Cand);
    Diff == MinDiff ->
        find_closest_recursive(Rest, N_int, Diff, min(CurrentResult, Cand));
    true ->
        find_closest_recursive(Rest, N_int, MinDiff, CurrentResult)
    end.