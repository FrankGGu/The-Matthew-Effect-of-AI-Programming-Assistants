-module(solution).
-export([longest_special_substring/1]).

longest_special_substring(S) ->
    CharRunsMap = get_char_runs(S),
    solve_char_runs(CharRunsMap).

get_char_runs(S) ->
    get_char_runs(S, #{}).

get_char_runs([], Map) -> Map;
get_char_runs([H|T], Map) ->
    {Prefix, Rest} = lists:splitwith(fun(C) -> C == H end, T),
    RunLength = length(Prefix) + 1,
    NewMap = maps:update_with(H, fun(List) -> [RunLength|List] end, [RunLength], Map),
    get_char_runs(Rest, NewMap).

solve_char_runs(CharRunsMap) ->
    maps:fold(fun(_Char, Lengths, AccMaxL) ->
                      SortedLengths = lists:sort(fun(A, B) -> A >= B end, Lengths),
                      % Pad with 0s to ensure K1, K2, K3 always exist without error
                      [K1, K2, K3|_] = SortedLengths ++ [0, 0, 0],

                      % Case 1: All 3 occurrences from the longest run (K1)
                      % We need K1 - L + 1 >= 3, which implies L <= K1 - 2.
                      L1 = if K1 >= 3 -> K1 - 2; true -> 0 end,

                      % Case 2: 3 occurrences from the two longest runs (K1 and K2)
                      % To get 3 occurrences, we can aim for 2 from K1 and 1 from K2.
                      % This requires L <= K1 - 1 (for 2 from K1) and L <= K2 (for 1 from K2).
                      % So, L = min(K1 - 1, K2).
                      L2 = if K1 >= 2 andalso K2 >= 1 -> min(K1 - 1, K2); true -> 0 end,

                      % Case 3: 3 occurrences from the three longest runs (K1, K2, K3)
                      % To get 3 occurrences, we can aim for 1 from each.
                      % This requires L <= K1, L <= K2, L <= K3.
                      % Since K1 >= K2 >= K3, this simplifies to L <= K3.
                      L3 = if K3 >= 1 -> K3; true -> 0 end,

                      CurrentCharMaxL = lists:max([L1, L2, L3]),
                      max(AccMaxL, CurrentCharMaxL)
              end, -1, CharRunsMap).