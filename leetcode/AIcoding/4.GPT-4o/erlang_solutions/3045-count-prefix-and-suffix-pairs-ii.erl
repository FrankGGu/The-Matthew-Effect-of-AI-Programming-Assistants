-module(solution).
-export([count_prefix_suffix_pairs/1]).

count_prefix_suffix_pairs(Words) ->
    Prefixes = lists:map(fun(X) -> {X, string:to_list(X)} end, Words),
    Suffixes = lists:map(fun(X) -> {X, lists:reverse(string:to_list(X))} end, Words),
    PrefixMap = lists:foldl(fun({W, P}, Acc) -> maps:update_with(P, fun(Count) -> Count + 1 end, 1, Acc) end, #{}, Prefixes),
    SuffixMap = lists:foldl(fun({W, S}, Acc) -> maps:update_with(S, fun(Count) -> Count + 1 end, 1, Acc) end, #{}, Suffixes),
    lists:foldl(fun(Prefix, Acc) -> 
        case maps:find(Prefix, SuffixMap) of
            {ok, Count} -> Acc + Count;
            _ -> Acc
        end
    end, 0, maps:keys(PrefixMap)).