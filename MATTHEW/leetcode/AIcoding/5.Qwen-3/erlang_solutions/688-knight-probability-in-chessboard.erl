-module(knight_probability).
-export([knight_probability/3]).

knight_probability(N, K, r, c) ->
    Directions = [{-1, -2}, {-2, -1}, {-2, 1}, {-1, 2}, {1, 2}, {2, 1}, {2, -1}, {1, -2}],
    DP = array:new([{size, N}, {default, 0.0}]),
    array:set({r, c}, 1.0, DP),
    knight_probability(K, Directions, DP, N).

knight_probability(0, _, DP, _) -> array:get({r, c}, DP);
knight_probability(Steps, Directions, DP, N) ->
    NextDP = array:new([{size, N}, {default, 0.0}]),
    lists:foreach(fun({R, C}) ->
        Val = array:get({R, C}, DP),
        if Val > 0.0 ->
            lists:foreach(fun({DR, DC}) ->
                NR = R + DR,
                NC = C + DC,
                if NR >= 0 andalso NR < N andalso NC >= 0 andalso NC < N ->
                    NextVal = array:get({NR, NC}, NextDP) + Val / 8.0,
                    array:set({NR, NC}, NextVal, NextDP);
                true -> ok
                end
            end, Directions);
        true -> ok
        end
    end, array:to_list(DP)),
    knight_probability(Steps - 1, Directions, NextDP, N).