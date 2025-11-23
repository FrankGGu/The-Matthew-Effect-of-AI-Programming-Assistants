-module(minimum_number_of_days_to_eat_n_oranges).
-export([minDays/1]).

minDays(N) ->
    minDays(N, #{}).

minDays(0, _) ->
    0;
minDays(N, Cache) ->
    case maps:find(N, Cache) of
        {ok, V} ->
            V;
        error ->
            Res = case N rem 2 of
                      0 ->
                          minDays(N div 2, Cache) + 1;
                      _ ->
                          minDays(N - 1, Cache) + 1
                  end,
            Res2 = case N rem 3 of
                       0 ->
                           minDays(N div 3, Cache) + 1;
                       _ ->
                           Res
                   end,
            NewCache = maps:put(N, Res2, Cache),
            Res2
    end.