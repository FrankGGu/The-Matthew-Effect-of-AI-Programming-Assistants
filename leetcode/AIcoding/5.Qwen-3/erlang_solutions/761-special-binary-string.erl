-module(special_binary_string).
-export([special_binary_string/1]).

special_binary_string(S) ->
    lists:flatten(special_binary_string_helper(S)).

special_binary_string_helper([]) ->
    [];
special_binary_string_helper(S) ->
    Count = 0,
    Start = 0,
    special_binary_string_helper(S, Count, Start, []).

special_binary_string_helper([], _, _, Acc) ->
    lists:reverse(Acc);
special_binary_string_helper([H|T], Count, Start, Acc) ->
    case H of
        $'(' ->
            NewCount = Count + 1;
        $')' ->
            NewCount = Count - 1
    end,
    if
        NewCount == 0 ->
            Sub = lists:sublist(S, Start+1, length(S) - Start - 1),
            [lists:append([$'(', special_binary_string_helper(Sub), $')']) | special_binary_string_helper(T, 0, 0, Acc)];
        true ->
            special_binary_string_helper(T, NewCount, Start, Acc)
    end.