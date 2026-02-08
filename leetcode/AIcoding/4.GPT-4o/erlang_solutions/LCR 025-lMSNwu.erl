-module(solution).
-export([add_two_numbers/2]).

-type list() :: [] | [{integer()}].
-type node() :: {Value, Next} | nil.
-record(node, {value, next}).

add_two_numbers(L1, L2) ->
    Rev1 = reverse_list(L1),
    Rev2 = reverse_list(L2),
    SumList = add_lists(Rev1, Rev2, 0),
    reverse_list(SumList).

reverse_list([]) -> [];
reverse_list([H | T]) -> [H | reverse_list(T)].

add_lists([], [], 0) -> [];
add_lists([], [], Carry) -> [Carry];
add_lists([], [H2 | T2], Carry) ->
    Sum = H2 + Carry,
    [Sum rem 10 | add_lists([], T2, Sum div 10)];
add_lists([H1 | T1], [], Carry) ->
    Sum = H1 + Carry,
    [Sum rem 10 | add_lists(T1, [], Sum div 10)];
add_lists([H1 | T1], [H2 | T2], Carry) ->
    Sum = H1 + H2 + Carry,
    [Sum rem 10 | add_lists(T1, T2, Sum div 10)].