-module(closest_divisors).
-export([closest_divisors/1]).

closest_divisors(N) ->
    {A, B} = find_closest(N),
    [A, B].

find_closest(N) ->
    find_closest(N, 1, 1, N).

find_closest(N, I, A, B) when I * I > N ->
    {A, B};
find_closest(N, I, A, B) ->
    case N rem I of
        0 ->
            NewA = I,
            NewB = N div I,
            if
                (NewB - NewA) < (B - A) ->
                    find_closest(N, I + 1, NewA, NewB);
                true ->
                    find_closest(N, I + 1, A, B)
            end;
        _ ->
            find_closest(N, I + 1, A, B)
    end.