-module(solution).
-export([frequency_sort/1]).

-spec frequency_sort(unicode:unicode_binary()) -> unicode:unicode_binary().
frequency_sort(S) ->
    %% Step 1: Count the frequency of each character in the string.
    Frequency = lists:foldl(fun(C, Acc) ->
                                  case maps:find(C, Acc) of
                                      {ok, Count} -> maps:put(C, Count + 1, Acc);
                                      error -> maps:put(C, 1, Acc)
                                  end
                              end, #{}, string:characters(S)),

    %% Step 2: Sort characters by frequency in descending order.
    Sorted = lists:sort(fun({_, F1}, {_, F2}) -> F1 >= F2 end, maps:to_list(Frequency)),

    %% Step 3: Rebuild the string based on sorted frequencies.
    lists:foldl(fun({Char, Count}, Acc) ->
                    lists:append(Acc, lists:duplicate(Count, Char))
                end, [], Sorted).
