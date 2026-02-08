-module(solution).
-export([get_intersection_node/2]).

-type list_node() :: {none} | {Value, list_node()}.

get_intersection_node(List1, List2) ->
    Length1 = length(List1),
    Length2 = length(List2),
    {L1, L2} = if
        Length1 >= Length2 -> {List1, List2};
        true -> {List2, List1}
    end,
    {L1, L2} = find_intersection(L1, L2, Length1, Length2).

find_intersection(L1, L2, Len1, Len2) when Len1 > Len2 ->
    find_intersection(tl(L1), L2, Len1 - 1, Len2);
find_intersection(L1, L2, Len1, Len2) when Len1 < Len2 ->
    find_intersection(L1, tl(L2), Len1, Len2 - 1);
find_intersection(L1, L2, _, _) ->
    case {L1, L2} of
        {none, _} -> none;
        {_, none} -> none;
        {H1, H2} when H1 =:= H2 -> H1;
        {_, _} -> find_intersection(tl(L1), tl(L2), 0, 0)
    end.