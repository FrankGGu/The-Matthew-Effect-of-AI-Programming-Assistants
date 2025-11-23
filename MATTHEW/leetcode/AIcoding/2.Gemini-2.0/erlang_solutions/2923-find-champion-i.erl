-module(find_champion_i).
-export([find_champion/1]).

find_champion(Matches) ->
  Map = lists:foldl(fun([Winner, Loser]) ->
                      fun(M) ->
                          M1 = maps:update_with(Winner, fun(X) -> X + 1 end, 1, M),
                          maps:update_with(Loser, fun(X) -> X + 1 end, 1, M1)
                      end
                  end, maps:new(), Matches),

  Winners = lists:usort([W || [W, _] <- Matches]),

  case lists:filter(fun(W) -> not maps:is_key(W, Map) orelse maps:get(W, Map) == 1 end, Winners) of
    [Winner] -> Winner;
    _ -> -1
  end.