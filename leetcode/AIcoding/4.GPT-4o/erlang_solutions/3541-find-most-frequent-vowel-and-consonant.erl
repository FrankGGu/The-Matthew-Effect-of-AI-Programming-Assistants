-module(solution).
-export([most_frequent/1]).

most_frequent(S) ->
    Vowels = "aeiou",
    Consonants = "bcdfghjklmnpqrstvwxyz",
    Counts = lists:foldl(fun(C, Acc) ->
        case lists:member(C, Vowels) of
            true -> update_count(C, Acc, vowels);
            false -> case lists:member(C, Consonants) of
                true -> update_count(C, Acc, consonants);
                false -> Acc
            end
        end
    end, #{vowels => #{}, consonants => #{}}, string:to_lower(S)),
    MostVowel = get_most_frequent(Counts, vowels),
    MostConsonant = get_most_frequent(Counts, consonants),
    {MostVowel, MostConsonant}.

update_count(Char, Acc, Type) ->
    CountMap = maps:get(Type, Acc),
    NewCountMap = maps:update_with(Char, fun(X) -> X + 1 end, 1, CountMap),
    maps:put(Type, NewCountMap, Acc).

get_most_frequent(Counts, Type) ->
    Map = maps:get(Type, Counts),
    lists:max(lists:foldl(fun({K, V}, Acc) -> 
        case Acc of
            {MaxKey, MaxVal} when V > MaxVal -> {K, V};
            _ -> Acc
        end
    end, {"", 0}, maps:to_list(Map))).