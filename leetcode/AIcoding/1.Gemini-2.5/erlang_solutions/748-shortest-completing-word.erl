-module(solution).
-export([shortest_completing_word/2]).

shortest_completing_word(LicensePlate, Words) ->
    LP_Lower = string:to_lower(LicensePlate),
    LP_Counts = count_chars(LP_Lower),

    lists:foldl(fun(Word, {MinLen, ResultWord}) ->
                    case completes(LP_Counts, Word) of
                        true ->
                            WordLen = length(Word),
                            case WordLen < MinLen of
                                true ->
                                    {WordLen, Word};
                                false ->
                                    {MinLen, ResultWord}
                            end;
                        false ->
                            {MinLen, ResultWord}
                    end
                end, {infinity, []}, Words)
    end.

count_chars(S) ->
    lists:foldl(fun(C, Acc) ->
                    case C >= $a andalso C =< $z of
                        true ->
                            maps:update_with(C, fun(V) -> V + 1 end, 1, Acc);
                        false ->
                            Acc
                    end
                end, #{}, S).

completes(LicensePlateCounts, Word) ->
    WordCounts = count_chars(Word),
    maps:fold(fun(Char, RequiredCount, Acc) ->
                  case Acc of
                      false -> false;
                      true ->
                          WordCount = maps:get(Char, WordCounts, 0),
                          WordCount >= RequiredCount
                  end
              end, true, LicensePlateCounts).