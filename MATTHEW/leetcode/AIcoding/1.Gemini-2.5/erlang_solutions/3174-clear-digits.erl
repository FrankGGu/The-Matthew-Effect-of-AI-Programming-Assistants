-module(solution).
-export([clear_digits/1]).

clear_digits(S) ->
    ResultList = clear_digits_acc(binary_to_list(S), []),
    list_to_binary(ResultList).

clear_digits_acc([], Acc) ->
    lists:reverse(Acc);
clear_digits_acc([H|T], Acc) when H >= $0, H =< $9 ->
    case Acc of
        [] -> clear_digits_acc(T, []);
        [_|AccTail] -> clear_digits_acc(T, AccTail)
    end;
clear_digits_acc([H|T], Acc) ->
    clear_digits_acc(T, [H|Acc]).