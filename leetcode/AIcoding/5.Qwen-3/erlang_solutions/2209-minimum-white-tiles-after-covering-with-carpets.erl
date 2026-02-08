-module(minimum_white_tiles_after_covering_with_carpets).
-export([carpets/2]).

carpets(White, Carpets) ->
    N = length(White),
    DP = array:new(N + 1, {default, 0}),
    carps(Carpets, White, 0, DP).

carps([], _, _, DP) ->
    array:get(N, DP);
carps([L | Rest], White, I, DP) ->
    NewDP = array:new(N + 1, {default, 0}),
    J = I,
    K = I + L - 1,
    if
        K >= N -> 
            for(I, N, fun(Ix) -> array:set(Ix, max(array:get(Ix, DP), array:get(Ix - 1, DP)), NewDP) end);
        true ->
            for(I, N, fun(Ix) ->
                if
                    Ix < J -> array:set(Ix, array:get(Ix, DP), NewDP);
                    Ix > K -> array:set(Ix, max(array:get(Ix, DP), array:get(Ix - 1, DP)), NewDP);
                    true -> array:set(Ix, max(array:get(Ix, DP), array:get(Ix - 1, DP)), NewDP)
                end
            end)
    end,
    carps(Rest, White, I + 1, NewDP).

for(A, B, F) when A > B -> ok;
for(A, B, F) ->
    F(A),
    for(A + 1, B, F).