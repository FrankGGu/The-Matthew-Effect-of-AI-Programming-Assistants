-module(longest_special_substring).
-export([longest_special_substring/1]).

longest_special_substring(S) ->
    longest_special_substring(S, 0).

longest_special_substring(S, Acc) ->
    N = length(S),
    longest_special_substring(S, N, Acc).

longest_special_substring(S, L, Acc) ->
    if
        L < 1 ->
            Acc;
        true ->
            case check_substring(S, L) of
                true ->
                    L;
                false ->
                    longest_special_substring(S, L - 1, Acc)
            end
    end.

check_substring(S, L) ->
    N = length(S),
    check_substring(S, L, N, {}).

check_substring(S, L, N, Seen) ->
    check_substring(S, L, N, 0, Seen).

check_substring(S, L, N, Start, Seen) ->
    if
        Start + L > N ->
            false;
        true ->
            Sub = lists:sublist(S, Start + 1, L),
            IsSpecial = is_special(Sub),
            case IsSpecial of
                true ->
                    case maps:is_key(Sub, Seen) of
                        true ->
                            Count = maps:get(Sub, Seen),
                            if
                                Count >= 2 ->
                                    true;
                                true ->
                                    NewSeen = maps:put(Sub, Count + 1, Seen),
                                    check_substring(S, L, N, Start + 1, NewSeen)
                            end;
                        false ->
                            NewSeen = maps:put(Sub, 1, Seen),
                            check_substring(S, L, N, Start + 1, NewSeen)
                    end;
                false ->
                    check_substring(S, L, N, Start + 1, Seen)
            end.

is_special(Sub) ->
    is_special(Sub, 1).

is_special([_]) ->
    true;
is_special([H | T], Count) ->
    case T of
        [] ->
            true;
        [Next | Rest] ->
            if
                H == Next ->
                    is_special([Next | Rest], Count + 1);
                true ->
                    false
            end
    end.