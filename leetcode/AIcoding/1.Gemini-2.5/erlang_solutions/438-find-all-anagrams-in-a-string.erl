-module(solution).
-export([findAnagrams/2]).

init_counts() ->
    lists:duplicate(26, 0).

increment_char(Char, Counts) ->
    Index = Char - $a,
    CurrentCount = lists:nth(Index + 1, Counts),
    lists:replace_nth(Index + 1, CurrentCount + 1, Counts).

decrement_char(Char, Counts) ->
    Index = Char - $a,
    CurrentCount = lists:nth(Index + 1, Counts),
    lists:replace_nth(Index + 1, CurrentCount - 1, Counts).

build_initial_counts_recursive([], _Len, Counts, _CurrentIdx) ->
    Counts;
build_initial_counts_recursive([H|T], Len, Counts, CurrentIdx) ->
    NewCounts = increment_char(H, Counts),
    build_initial_counts_recursive(T, Len, NewCounts, CurrentIdx + 1).

findAnagrams(S, P) ->
    LenS = length(S),
    LenP = length(P),

    if
        LenP > LenS -> [];
        true ->
            P_Counts = build_initial_counts_recursive(P, LenP, init_counts(), 0),

            InitialWindowS = lists:sublist(S, 1, LenP),
            S_Window_Counts = build_initial_counts_recursive(InitialWindowS, LenP, init_counts(), 0),

            CurrentResults = if
                                 P_Counts == S_Window_Counts -> [0];
                                 true -> []
                             end,

            slide_window(S, P_Counts, S_Window_Counts, LenP, LenS, LenP, CurrentResults)
    end.

slide_window(S, P_Counts, S_Window_Counts, LenP, LenS, RightIdx, AccResults) ->
    if
        RightIdx >= LenS ->
            lists:reverse(AccResults);
        true ->
            CharEntering = lists:nth(RightIdx + 1, S),
            New_S_Window_Counts_After_Enter = increment_char(CharEntering, S_Window_Counts),

            CharLeaving = lists:nth((RightIdx - LenP) + 1, S),
            New_S_Window_Counts = decrement_char(CharLeaving, New_S_Window_Counts_After_Enter),

            CurrentAccResults = if
                                    P_Counts == New_S_Window_Counts ->
                                        [RightIdx - LenP + 1 | AccResults];
                                    true ->
                                        AccResults
                                end,

            slide_window(S, P_Counts, New_S_Window_Counts, LenP, LenS, RightIdx + 1, CurrentAccResults)
    end.