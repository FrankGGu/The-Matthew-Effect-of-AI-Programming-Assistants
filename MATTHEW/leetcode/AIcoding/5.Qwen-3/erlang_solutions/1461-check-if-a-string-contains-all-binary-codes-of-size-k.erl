-module(solution).
-export([has_all_codes/2]).

has_all_codes(S, K) ->
    N = length(S),
    if
        K > N -> false;
        true ->
            Total = 1 bsl K,
            Set = sets:new(),
            collect_codes(S, K, 0, Set, N, 0)
    end.

collect_codes(_, _, _, Set, _, _) when sets:size(Set) == 1 bsl K -> true;
collect_codes([], _, _, Set, _, _) -> sets:size(Set) == 1 bsl K;
collect_codes([C | T], K, Index, Set, N, Count) ->
    if
        Index + K > N -> collect_codes(T, K, 0, Set, N, Count);
        true ->
            Code = get_code(S, Index, K),
            NewSet = sets:add_element(Code, Set),
            collect_codes(T, K, Index + 1, NewSet, N, Count + 1)
    end.

get_code(S, Start, K) ->
    lists:sublist(S, Start + 1, K).