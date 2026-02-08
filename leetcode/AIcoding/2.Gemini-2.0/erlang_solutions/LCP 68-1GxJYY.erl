-module(beautiful_flower_bouquet).
-export([get_the_most_beautiful_bouquet/2]).

get_the_most_beautiful_bouquet(flowers, cnt) ->
    get_the_most_beautiful_bouquet(flowers, cnt, 0, 0, 1000000007).

get_the_most_beautiful_bouquet([], 0, Sum, _, Mod) ->
    Sum rem Mod;
get_the_most_beautiful_bouquet([], _, _, _, _) ->
    0;
get_the_most_beautiful_bouquet(_, 0, Sum, _, Mod) ->
    Sum rem Mod;
get_the_most_beautiful_bouquet([H|T], Cnt, Sum, Pow, Mod) ->
    (get_the_most_beautiful_bouquet(T, Cnt - 1, (Sum + (Pow * H) rem Mod) rem Mod, (Pow * 2) rem Mod, Mod) +
     get_the_most_beautiful_bouquet(T, Cnt, Sum, Pow, Mod)) rem Mod.