-module(solution).
-export([prefix_suffix_pairs/1]).

prefix_suffix_pairs(Words) ->
    Count = maps:new(),
    Total = 0,
    lists:foldl(fun(W, Acc) -> 
        Prefixes = get_prefixes(W),
        Suffixes = get_suffixes(W),
        lists:foldl(fun(P, A) -> 
            case maps:is_key(P, Count) of
                true -> maps:update(P, maps:get(P, Count) + 1, A);
                false -> maps:put(P, 1, A)
            end
        end, Acc, Prefixes ++ Suffixes)
    end, Count, Words),
    maps:values(Count).

get_prefixes(S) ->
    get_prefixes(S, 1, []).

get_prefixes(_, N, Acc) when N > length(S) -> Acc;
get_prefixes(S, N, Acc) ->
    get_prefixes(S, N+1, [string:substr(S, 1, N) | Acc]).

get_suffixes(S) ->
    get_suffixes(S, length(S), []).

get_suffixes(_, N, Acc) when N < 1 -> Acc;
get_suffixes(S, N, Acc) ->
    get_suffixes(S, N-1, [string:substr(S, N) | Acc]).