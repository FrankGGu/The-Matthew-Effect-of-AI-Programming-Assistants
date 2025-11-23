-module(fuzzy_search).
-export([is_fuzzy_match/2]).

is_fuzzy_match(Needle, Haystack) ->
    is_fuzzy_match(Needle, Haystack, 0, 0).

is_fuzzy_match([], _, _, _) ->
    true;
is_fuzzy_match(_, [], NeedleIndex, _) when NeedleIndex < length(_) ->
    false;
is_fuzzy_match([NeedleChar | NeedleRest], [HaystackChar | HaystackRest], NeedleIndex, HaystackIndex) ->
    case NeedleChar =:= HaystackChar of
        true ->
            is_fuzzy_match(NeedleRest, HaystackRest, NeedleIndex + 1, HaystackIndex + 1);
        false ->
            is_fuzzy_match([NeedleChar | NeedleRest], HaystackRest, NeedleIndex, HaystackIndex + 1)
    end.