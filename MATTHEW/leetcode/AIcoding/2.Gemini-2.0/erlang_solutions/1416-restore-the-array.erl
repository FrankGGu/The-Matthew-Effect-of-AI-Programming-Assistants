-module(restore_array).
-export([number_of_arrays/2]).

number_of_arrays(S, K) ->
    Len = length(S),
    Memo = dict:new(),
    number_of_arrays_helper(S, 0, K, Memo, Len).

number_of_arrays_helper(_S, Len, _K, _Memo, Len) ->
    1;
number_of_arrays_helper(S, Index, K, Memo, Len) ->
    case dict:find(Index, Memo) of
        {ok, Value} ->
            Value;
        error ->
            case char_to_integer(lists:nth(Index + 1, string:to_list(S))) of
                0 ->
                    dict:store(Index, 0, Memo),
                    0;
                _ ->
                    Result = number_of_arrays_helper_impl(S, Index, K, Memo, Len, 0),
                    dict:store(Index, Result, Memo),
                    Result
            end
    end.

number_of_arrays_helper_impl(S, Index, K, Memo, Len, Acc) ->
    case Index >= Len of
        true ->
            Acc;
        false ->
            Substr = string:sub(S, Index + 1, Len - Index),
            case string:to_integer(Substr) of
                {Value, _} when Value > K ->
                    Acc;
                {Value, _} ->
                    NewAcc = (Acc + number_of_arrays_helper(S, Index + integer_to_list_length(Value), K, Memo, Len)) rem 1000000007,
                    number_of_arrays_helper_impl(S, Index, K, Memo, Len, NewAcc);
                error ->
                    Acc
            end
    end.

integer_to_list_length(N) ->
    integer_to_list_length_helper(N, 0).

integer_to_list_length_helper(0, Acc) ->
    Acc;
integer_to_list_length_helper(N, Acc) ->
    integer_to_list_length_helper(N div 10, Acc + 1).

char_to_integer(Char) ->
    Char - $0.