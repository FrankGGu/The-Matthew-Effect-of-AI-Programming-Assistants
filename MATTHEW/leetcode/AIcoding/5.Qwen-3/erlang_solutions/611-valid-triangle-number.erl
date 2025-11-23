-module(solution).
-export([triangle_number/1]).

triangle_number(Nums) ->
    Sorted = lists:sort(Nums),
    triangle_number(Sorted, 0, 0, 0).

triangle_number(_, _, _, Count) when Count >= 1000000 -> Count;
triangle_number([], _, _, Count) -> Count;
triangle_number([_], _, _, Count) -> Count;
triangle_number([_A, _B | _], _, _, Count) when Count >= 1000000 -> Count;
triangle_number([A, B | Rest], I, J, Count) ->
    case A + B > hd(Rest) of
        true ->
            NewCount = Count + length(Rest),
            triangle_number([A, B | Rest], I, J + 1, NewCount);
        false ->
            triangle_number([A, B | Rest], I + 1, J, Count)
    end.