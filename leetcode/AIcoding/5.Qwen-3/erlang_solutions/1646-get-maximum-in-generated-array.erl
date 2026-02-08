-module(solution).
-export([get_max/1]).

get_max(N) ->
    get_max(N, 1, [0, 1], 1).

get_max(1, _, _, Max) ->
    Max;
get_max(2, _, _, Max) ->
    Max;
get_max(N, I, Arr, Max) when I < N ->
    Val = case I rem 2 of
              0 -> lists:nth(I div 2 + 1, Arr);
              _ -> lists:nth((I - 1) div 2 + 1, Arr) + lists:nth((I + 1) div 2 + 1, Arr)
          end,
    NewArr = Arr ++ [Val],
    NewMax = max(Max, Val),
    get_max(N, I + 1, NewArr, NewMax).