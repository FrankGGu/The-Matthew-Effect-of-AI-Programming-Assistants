-module(lonely_numbers).
-export([find_lonely/1]).

find_lonely(Nums) ->
  Counts = lists:foldl(fun(N, Acc) ->
    case maps:is_key(N, Acc) of
      true -> maps:update(N, maps:get(N, Acc) + 1, Acc);
      false -> maps:put(N, 1, Acc)
    end
  end, #{}, Nums),

  lists:filter(fun(N) ->
    case maps:get(N, Counts) of
      1 ->
        case maps:is_key(N - 1, Counts) of
          true -> false;
          false ->
            case maps:is_key(N + 1, Counts) of
              true -> false;
              false -> true
            end
        end;
      _ -> false
    end
  end, Nums).