-module(maximum_good_people).
-export([maximum_good_people/1]).

maximum_good_people(Statements) ->
  N = length(Statements),
  MaxGood = 0,
  for(Mask) ->
    if
      is_valid(Mask, Statements, N) ->
        GoodPeople = count_set_bits(Mask, N),
        MaxGood = max(MaxGood, GoodPeople);
      true ->
        ok
    end
  end,
  MaxGood.

for(Mask) ->
  N = length(Mask),
  for(I) ->
    Mask ! I
  end
end.

for(I) ->
  if I < (1 bsl 15) ->
    receive
      I ->
        I
    after 0 ->
      ok
    end,
    for(I + 1)
  end.

is_valid(Mask, Statements, N) ->
  lists:all(fun(I) ->
                if
                  (Mask band (1 bsl (I - 1))) > 0 ->
                    lists:all(fun(J) ->
                                  Statement = lists:nth(J, lists:nth(I, Statements)),
                                  case Statement of
                                    0 ->
                                      true;
                                    1 ->
                                      (Mask band (1 bsl (J - 1))) > 0;
                                    0 ->
                                      not ((Mask band (1 bsl (J - 1))) > 0);
                                    _ ->
                                      false
                                  end
                              end, lists:seq(1, N));
                  true ->
                    true
                end
            end, lists:seq(1, N)).

count_set_bits(Mask, N) ->
  count_set_bits(Mask, N, 0).

count_set_bits(0, _, Count) ->
  Count;
count_set_bits(Mask, N, Count) ->
  count_set_bits(Mask band (Mask - 1), N, Count + 1).