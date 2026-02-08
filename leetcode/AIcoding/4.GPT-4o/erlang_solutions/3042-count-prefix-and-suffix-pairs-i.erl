-module(solution).
-export([count_prefix_suffix_pairs/1]).

count_prefix_suffix_pairs(Words) ->
    N = length(Words),
    Prefixes = lists:map(fun(W) -> string:to_list(W) end, Words),
    Suffixes = lists:map(fun(W) -> string:to_list(W) end, Words),
    Count = lists:foldl(fun(Prefix, Acc) ->
        lists:foldl(fun(Suffix, Acc1) ->
            if lists:prefix(Prefix, Suffix) orelse lists:suffix(Prefix, Suffix) ->
                Acc1 + 1;
            true -> 
                Acc1
            end
        end, Acc, Suffixes)
    end, 0, Prefixes),
    Count.