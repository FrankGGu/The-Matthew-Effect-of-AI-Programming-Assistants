-module(solution).
-export([maximum_removals/3]).

maximum_removals(S, P, Removable) ->
    {Low, High} = {0, length(Removable)},
    binary_search(S, P, Removable, Low, High).

binary_search(S, P, Removable, Low, High) when Low < High ->
    Mid = (Low + High + 1) div 2,
    case is_subsequence(S, P, Removable, Mid) of
        true -> binary_search(S, P, Removable, Mid, High);
        false -> binary_search(S, P, Removable, Low, Mid - 1)
    end;
binary_search(_S, _P, _Removable, Low, _High) ->
    Low.

is_subsequence(S, P, Removable, K) ->
    Removed = sets:from_list(lists:sublist(Removable, K)),
    S1 = filter_removed(S, Removed, 0),
    check_subsequence(S1, P).

filter_removed(<<>>, _Removed, _Index) -> <<>>;
filter_removed(<<C:8, Rest/binary>>, Removed, Index) ->
    case sets:is_element(Index, Removed) of
        true -> filter_removed(Rest, Removed, Index + 1);
        false -> <<C:8, (filter_removed(Rest, Removed, Index + 1))/binary>>
    end.

check_subsequence(<<>>, <<>>) -> true;
check_subsequence(<<>>, _P) -> false;
check_subsequence(_S, <<>>) -> true;
check_subsequence(<<C:8, S/binary>>, <<C:8, P/binary>>) -> check_subsequence(S, P);
check_subsequence(<<_:8, S/binary>>, P) -> check_subsequence(S, P).