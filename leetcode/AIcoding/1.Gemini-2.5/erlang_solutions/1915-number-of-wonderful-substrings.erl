-module(solution).
-export([wonderfulSubstrings/1]).

-spec wonderfulSubstrings(S :: string()) -> integer().
wonderfulSubstrings(S) ->
    wonderfulSubstrings_impl(S, 0, #{0 => 1}, 0).

wonderfulSubstrings_impl([], _CurrentMask, _FreqMap, Count) ->
    Count;
wonderfulSubstrings_impl([C | Rest], CurrentMask, FreqMap, Count) ->
    CharOffset = C - $a,
    NewMask = CurrentMask bxor (1 bsl CharOffset),

    % Case 1: current_mask XOR prefix_mask[i] == 0
    % This means prefix_mask[i] == NewMask
    CountFromZeroOdd = maps:get(NewMask, FreqMap, 0),

    % Case 2: current_mask XOR prefix_mask[i] == (1 << k)
    % This means prefix_mask[i] == NewMask XOR (1 << k)
    CountFromOneOdd = lists:foldl(
        fun(K, Acc) ->
            Acc + maps:get(NewMask bxor (1 bsl K), FreqMap, 0)
        end,
        0,
        lists:seq(0, 9) % Iterate through all 10 possible characters 'a' through 'j'
    ),

    TotalNewCount = Count + CountFromZeroOdd + CountFromOneOdd,

    UpdatedFreqMap = maps:update_with(NewMask, fun(V) -> V + 1 end, 1, FreqMap),

    wonderfulSubstrings_impl(Rest, NewMask, UpdatedFreqMap, TotalNewCount).