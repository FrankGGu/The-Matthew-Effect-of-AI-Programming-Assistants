-module(weak_characters).
-export([number_of_weak_characters/1]).

number_of_weak_characters(Properties) ->
    SortedProperties = lists:sort(fun({A1, D1}, {A2, D2}) ->
                                          if A1 > A2 ->
                                              true;
                                          A1 == A2 ->
                                              D1 < D2;
                                          true ->
                                              false
                                          end
                                  end, Properties),
    number_of_weak_characters_helper(SortedProperties, -1, 0).

number_of_weak_characters_helper([], _MaxDefense, Count) ->
    Count;
number_of_weak_characters_helper([{_Attack, Defense} | Rest], MaxDefense, Count) ->
    if Defense < MaxDefense ->
        number_of_weak_characters_helper(Rest, MaxDefense, Count + 1);
    true ->
        number_of_weak_characters_helper(Rest, max(MaxDefense, Defense), Count)
    end.