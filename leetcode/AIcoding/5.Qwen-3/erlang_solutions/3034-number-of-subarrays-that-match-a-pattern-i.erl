-module(solution).
-export([count_matching_subarrays/2]).

count_matching_subarrays(Word, Pattern) ->
    Len = length(Word),
    PatLen = length(Pattern),
    if
        PatLen == 0 -> 0;
        true ->
            Count = 0,
            lists:foldl(fun(I, Acc) ->
                                case match_pattern(Word, I, PatLen, Pattern) of
                                    true -> Acc + 1;
                                    false -> Acc
                                end
                            end, 0, lists:seq(0, Len - PatLen))
    end.

match_pattern(Word, Start, PatLen, Pattern) ->
    lists:all(fun(I) ->
                      WChar = lists:nth(Start + I + 1, Word),
                      PChar = lists:nth(I + 1, Pattern),
                      case PChar of
                          1 -> WChar > lists:nth(Start + I, Word);
                          -1 -> WChar < lists:nth(Start + I, Word);
                          0 -> WChar == lists:nth(Start + I, Word)
                      end
                  end, lists:seq(0, PatLen - 1)).