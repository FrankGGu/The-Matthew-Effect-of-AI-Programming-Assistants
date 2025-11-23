-module(solution).
-export([checkInclusion/2]).

checkInclusion(S1, S2) ->
    Len1 = length(S1),
    Len2 = length(S2),

    if
        Len1 > Len2 -> false;
        true ->
            S1Counts = lists:foldl(fun(C, Acc) ->
                                       Index = C - $a,
                                       lists:replace_nth(Index + 1, lists:nth(Index + 1, Acc) + 1, Acc)
                                   end, lists:duplicate(26, 0), S1),

            InitialWindow = lists:sublist(S2, 1, Len1),
            WindowCounts = lists:foldl(fun(C, Acc) ->
                                           Index = C - $a,
                                           lists:replace_nth(Index + 1, lists:nth(Index + 1, Acc) + 1, Acc)
                                       end, lists:duplicate(26, 0), InitialWindow),

            if
                S1Counts == WindowCounts -> true;
                true ->
                    slide_window(S1Counts, WindowCounts, S2, Len1, Len2, 0)
            end
    end.

slide_window(S1Counts, CurrentWindowCounts, S2, Len1, Len2, StartIndex) ->
    if
        StartIndex + Len1 >= Len2 -> false;
        true ->
            LeftChar = lists:nth(StartIndex + 1, S2),
            LeftIndex = LeftChar - $a,
            NewWindowCounts1 = lists:replace_nth(LeftIndex + 1, lists:nth(LeftIndex + 1, CurrentWindowCounts) - 1, CurrentWindowCounts),

            RightChar = lists:nth(StartIndex + Len1 + 1, S2),
            RightIndex = RightChar - $a,
            NewWindowCounts2 = lists:replace_nth(RightIndex + 1, lists:nth(RightIndex + 1, NewWindowCounts1) + 1, NewWindowCounts1),

            if
                S1Counts == NewWindowCounts2 -> true;
                true ->
                    slide_window(S1Counts, NewWindowCounts2, S2, Len1, Len2, StartIndex + 1)
            end
    end.