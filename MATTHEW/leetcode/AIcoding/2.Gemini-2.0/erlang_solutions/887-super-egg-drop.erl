-module(super_egg_drop).
-export([superEggDrop/3]).

superEggDrop(K, N) ->
  superEggDrop_helper(K, N, #{}, 1).

superEggDrop_helper(0, _, Cache, Ans) ->
  Ans;
superEggDrop_helper(_, 0, Cache, Ans) ->
  Ans;
superEggDrop_helper(_, 1, Cache, Ans) ->
  Ans;
superEggDrop_helper(K, N, Cache, Ans) ->
  case maps:is_key( {K, N}, Cache) of
    true ->
      maps:get( {K, N}, Cache);
    false ->
      Low = 1,
      High = N,
      Result =
        case K of
          1 -> N;
          _ ->
            binary_search(K, N, Low, High, Cache)
        end,
      NewCache = maps:put( {K, N}, Result, Cache),
      Result
  end.

binary_search(K, N, Low, High, Cache) ->
  case Low > High of
    true ->
      infinity;
    false ->
      Mid = (Low + High) div 2,
      Break = superEggDrop_helper(K - 1, Mid - 1, Cache, 1),
      NotBreak = superEggDrop_helper(K, N - Mid, Cache, 1),
      case Break > NotBreak of
        true ->
          binary_search(K, N, Low, Mid - 1, Cache);
        false ->
          case Break < NotBreak of
            true ->
              binary_search(K, N, Mid + 1, High, Cache);
            false ->
              Mid
          end
      end
  end + 1.