-module(solution).
-export([eaten_apples/2]).

eaten_apples(Apples, Days) ->
    eaten(Apples, Days, 0, 0).

eaten([], 0, Eaten, _) -> Eaten;
eaten([], Days, Eaten, _) -> eaten([], Days - 1, Eaten, 0);
eaten([H | T], Days, Eaten, 0) ->
    eaten(T, Days, Eaten, H);
eaten([H | T], Days, Eaten, Rem) ->
    case Rem of
        0 -> 
            eaten(T, Days - 1, Eaten, H - 1);
        _ when H > 0 -> 
            eaten(T, Days - 1, Eaten + 1, max(0, Rem - 1));
        _ -> 
            eaten(T, Days - 1, Eaten, 0)
    end.