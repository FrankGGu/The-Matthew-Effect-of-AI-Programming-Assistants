-module(longest_special_substring_thrice_i).
-export([longest_special_substring_thrice_i/1]).

longest_special_substring_thrice_i(S) ->
    longest_special_substring_thrice_i(S, length(S)).

longest_special_substring_thrice_i(S, Length) ->
    case Length of
        0 -> -1;
        _ ->
            case check_length(S, Length) of
                true -> Length;
                false -> longest_special_substring_thrice_i(S, Length - 1)
            end
    end.

check_length(S, Length) ->
    check_length(S, Length, []).

check_length(S, Length, Acc) ->
    case string:len(S) < Length of
        true -> false;
        false ->
            Sub = string:substr(S, 1, Length),
            case is_special(Sub) of
                true ->
                    case lists:member(Sub, Acc) of
                        true ->
                            true;
                        false ->
                            NewAcc = [Sub | Acc],
                            case count_occurrences(S, Sub, 0) >= 3 of
                                true -> true;
                                false ->
                                    check_length(string:substr(S, 2, string:len(S) - 1), Length, NewAcc)
                            end
                    end;
                false ->
                    check_length(string:substr(S, 2, string:len(S) - 1), Length, Acc)
            end
    end.

is_special(Sub) ->
    is_special(Sub, 1).

is_special(Sub, Index) ->
    case Index > string:len(Sub) of
        true -> true;
        false ->
            case string:at(Sub, Index) == string:at(Sub, 1) of
                true -> is_special(Sub, Index + 1);
                false -> false
            end
    end.

count_occurrences(S, Sub, Count) ->
    case string:str(S, Sub) of
        0 -> Count;
        Pos ->
            NewS = string:substr(S, Pos + 1, string:len(S) - Pos),
            count_occurrences(NewS, Sub, Count + 1)
    end.