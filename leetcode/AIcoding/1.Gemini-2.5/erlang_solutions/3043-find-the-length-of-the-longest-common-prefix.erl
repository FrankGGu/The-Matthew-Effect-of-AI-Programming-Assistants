-module(solution).
-export([longest_common_prefix/1]).

longest_common_prefix([]) ->
    0;
longest_common_prefix([H | T]) ->
    find_lcp(T, H).

find_lcp([], CurrentPrefix) ->
    length(CurrentPrefix);
find_lcp([H | T], CurrentPrefix) ->
    NewPrefix = adjust_prefix(CurrentPrefix, H),
    find_lcp(T, NewPrefix).

adjust_prefix(Prefix, Str) ->
    case string:prefix(Prefix, Str) of
        true ->
            Prefix;
        false ->
            adjust_prefix(lists:droplast(Prefix), Str)
    end.