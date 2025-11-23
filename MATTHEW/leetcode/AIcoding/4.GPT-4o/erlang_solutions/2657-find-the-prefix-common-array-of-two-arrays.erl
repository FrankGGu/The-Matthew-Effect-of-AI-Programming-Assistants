-module(solution).
-export([find_prefix_common_array/2]).

find_prefix_common_array(A, B) ->
    find_prefix_common_array(A, B, 0, [], 0).

find_prefix_common_array([], _, _, Acc, _) ->
    lists:reverse(Acc);
find_prefix_common_array(_, [], _, Acc, _) ->
    lists:reverse(Acc);
find_prefix_common_array([H1 | T1], [H2 | T2], Count, Acc, Seen) ->
    NewSeen = lists:usort([H1 | Seen]),
    NewCount = lists:count(NewSeen, H1) + lists:count(NewSeen, H2),
    find_prefix_common_array(T1, T2, NewCount, [NewCount | Acc], NewSeen).