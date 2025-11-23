-module(longest_subsequence_repeated_k_times).
-export([longest_subsequence_repeated_k_times/2]).

longest_subsequence_repeated_k_times(S, K) ->
    longest_subsequence_repeated_k_times(S, K, []).

longest_subsequence_repeated_k_times(S, K, Acc) ->
    Chars = lists:usort(string:characters(S)),
    NextChars = lists:filter(fun(C) -> can_extend(S, Acc ++ [C], K) end, Chars),
    case NextChars of
        [] ->
            lists:flatten(Acc);
        _ ->
            lists:foldl(fun(C, Longest) ->
                                  NewLongest = longest_subsequence_repeated_k_times(S, K, Acc ++ [C]),
                                  case string:len(NewLongest) > string:len(Longest) of
                                      true ->
                                          NewLongest;
                                      false ->
                                          Longest
                                  end
                          end, "", NextChars)
    end.

can_extend(S, Subsequence, K) ->
    string:len(Subsequence) == 0 orelse
    can_find_k_times(S, Subsequence, K, 0, 0).

can_find_k_times(_S, _Subsequence, 0, _SIndex, _SubIndex) ->
    true;
can_find_k_times(S, Subsequence, K, SIndex, SubIndex) ->
    SLength = string:len(S),
    SubLength = string:len(Subsequence),
    case SIndex >= SLength of
        true ->
            false;
        false ->
            case SubIndex >= SubLength of
                true ->
                    can_find_k_times(S, Subsequence, K - 1, SIndex, 0);
                false ->
                    SChar = string:substr(S, SIndex + 1, 1),
                    SubChar = string:substr(Subsequence, SubIndex + 1, 1),
                    case SChar == SubChar of
                        true ->
                            can_find_k_times(S, Subsequence, K, SIndex + 1, SubIndex + 1);
                        false ->
                            can_find_k_times(S, Subsequence, K, SIndex + 1, SubIndex)
                    end
            end
    end.