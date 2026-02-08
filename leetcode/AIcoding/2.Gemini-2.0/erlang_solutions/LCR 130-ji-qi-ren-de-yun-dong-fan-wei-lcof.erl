-module(wardrobe_organizer).
-export([sort_clothes/1]).

sort_clothes(Clothes) ->
  lists:sort(fun(A, B) ->
                 case {A, B} of
                   {<<"red">>, _} -> true;
                   {_, <<"red">>} -> false;
                   {<<"yellow">>, _} when A =< B -> true;
                   {<<"yellow">>, _} -> false;
                   {_, <<"yellow">>} -> false;
                   {_, _} when A =< B -> true;
                   {_, _} -> false
                 end
             end, Clothes).