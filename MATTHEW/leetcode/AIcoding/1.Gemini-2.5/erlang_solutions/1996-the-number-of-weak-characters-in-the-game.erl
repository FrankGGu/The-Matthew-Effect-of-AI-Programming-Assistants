-module(solution).
-export([numberOfWeakCharacters/1]).

-spec numberOfWeakCharacters(Properties :: [[integer()]]) -> integer().
numberOfWeakCharacters(Properties) ->
    CharTuples = lists:map(fun([A, D]) -> {A, D} end, Properties),

    SortedChars = lists:sort(fun({A1, D1}, {A2, D2}) ->
                                    if
                                        A1 > A2 -> true;
                                        A1 < A2 -> false;
                                        true -> D1 < D2
                                    end
                            end, CharTuples),

    {WeakCount, _} = lists:foldl(fun({_A, D}, {CurrentWeakCount, CurrentMaxDefense}) ->
                                     if
                                         D < CurrentMaxDefense ->
                                             {CurrentWeakCount + 1, CurrentMaxDefense};
                                         true ->
                                             {CurrentWeakCount, max(CurrentMaxDefense, D)}
                                     end
                             end, {0, 0}, SortedChars),
    WeakCount.