-module(check_distances).
-export([check_distances/2]).

check_distances(S, Distance) ->
    check_distances(S, Distance, []).

check_distances([], _, _) ->
    true;
check_distances([H|T], Distance, Acc) ->
    case lists:member(H, Acc) of
        true ->
            check_distances(T, Distance, Acc);
        false ->
            Index1 = find_index(H, [H|T], 0),
            Index2 = find_index(H, T, 0),
            if Index2 == -1 then
                false
            else
                ActualDistance = Index2 - Index1 - 1,
                ExpectedDistance = lists:nth(H - $a + 1, Distance),
                if ActualDistance == ExpectedDistance then
                    check_distances(T, Distance, [H|Acc])
                else
                    false
                end
            end
    end.

find_index(_, [], _) ->
    -1;
find_index(Char, [H|T], Index) ->
    if H == Char then
        Index
    else
        find_index(Char, T, Index + 1)
    end.