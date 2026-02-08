-module(solution).
-export([maximum69Number/1]).

-spec maximum69Number(Num :: integer()) -> integer().
maximum69Number(Num) ->
    Str = integer_to_list(Num),
    maximum69Number_helper(Str, []).

maximum69Number_helper([], Acc) ->
    list_to_integer(lists:reverse(Acc));
maximum69Number_helper([H | T], Acc) when H == $6 ->
    list_to_integer(lists:reverse(Acc) ++ [$9 | T]);
maximum69Number_helper([H | T], Acc) ->
    maximum69Number_helper(T, [H | Acc]).