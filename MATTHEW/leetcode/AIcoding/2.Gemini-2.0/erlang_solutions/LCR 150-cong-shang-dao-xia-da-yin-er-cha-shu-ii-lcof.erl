-module(solution).
-export([solve/1]).

solve(A) ->
    lights(A, []).

lights([], Acc) ->
    lists:reverse(Acc);
lights([H|T], Acc) ->
    lights(T, [process_light(H) | Acc]).

process_light(Light) ->
    {Color, Brightness} = Light,
    case Brightness of
        B when B > 50 ->
            {Color, Brightness * 2};
        _ ->
            {Color, Brightness}
    end.