-module(solution).
-export([licenseKeyFormatting/2]).

licenseKeyFormatting(S, K) ->
    CleanedChars = [erlang:to_upper(C) || C <- S, C =/= $-],
    N = length(CleanedChars),

    if
        N == 0 ->
            "";
        true ->
            FirstGroupLen = 
                case N rem K of
                    0 -> K;
                    Rem -> Rem
                end,

            lists:flatten(format_groups_list(CleanedChars, FirstGroupLen, K))
    end.

format_groups_list(Chars, CurrentGroupSize, K) ->
    {Group, Rest} = lists:split(CurrentGroupSize, Chars),

    if
        Rest == [] ->
            [Group];
        true ->
            [Group, [$-] | format_groups_list(Rest, K, K)]
    end.