-module(remove_letter).
-export([equalize_frequency/1]).

equalize_frequency(S) ->
  equalize_frequency(string:to_list(S)).

equalize_frequency(S) ->
  Frequencies = lists:foldl(
    fun(C, Acc) ->
      case maps:is_key(C, Acc) of
        true -> maps:update(C, maps:get(C, Acc) + 1, Acc);
        false -> maps:put(C, 1, Acc)
      end
    end,
    #{},
    S
  ),

  equalize_frequency_helper(Frequencies).

equalize_frequency_helper(Frequencies) ->
  lists:any(
    fun(K) ->
      NewFrequencies = maps:update(K, maps:get(K, Frequencies) - 1, Frequencies),
      NewFrequenciesWithoutZero = maps:remove(K, NewFrequencies, maps:get(K, Frequencies) =:= 1),

      case maps:size(NewFrequenciesWithoutZero) of
        0 -> true;
        _ ->
          Values = maps:values(NewFrequenciesWithoutZero),
          lists:all(fun(V) -> V =:= lists:nth(1, Values) end, Values)
      end
    end,
    maps:keys(Frequencies)
  ).

maps:remove(Key, Map, ShouldRemove) ->
  case ShouldRemove of
    true -> maps:remove(Key, Map);
    false -> Map
  end.