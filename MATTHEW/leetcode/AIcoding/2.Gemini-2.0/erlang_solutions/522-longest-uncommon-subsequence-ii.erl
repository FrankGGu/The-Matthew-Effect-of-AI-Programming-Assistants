-module(longest_uncommon_subsequence_ii).
-export([find_lu_slength/1]).

is_subsequence(S, T) ->
    is_subsequence(S, T, 0, 0).

is_subsequence([], _, _, _) ->
    true;
is_subsequence(_, [], _, _) ->
    false;
is_subsequence([SH | ST], [TH | TT], I, J) ->
    if
        SH == TH ->
            is_subsequence(ST, TT, I + 1, J + 1);
        true ->
            is_subsequence([SH | ST], TT, I, J + 1)
    end.

find_lu_slength(Strs) ->
    find_lu_slength(Strs, -1).

find_lu_slength([], MaxLength) ->
    MaxLength;
find_lu_slength([Str | Rest], MaxLength) ->
    IsUncommon = lists:all(fun(OtherStr) ->
                                    if
                                        Str == OtherStr ->
                                            true;
                                        true ->
                                            not is_subsequence(Str, OtherStr)
                                    end
                            end, Rest),
    if
        IsUncommon ->
            Len = length(Str),
            NewMaxLength = max(MaxLength, Len),
            find_lu_slength(Rest, NewMaxLength);
        true ->
            find_lu_slength(Rest, MaxLength)
    end.