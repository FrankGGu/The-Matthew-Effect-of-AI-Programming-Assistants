-module(split_fibonacci).
-export([split_into_fibonacci/1]).

split_into_fibonacci(S) ->
    split_into_fibonacci_helper(string_to_list(S), [], 0).

split_into_fibonacci_helper([], Acc, _) ->
    case length(Acc) > 2 of
        true -> lists:reverse(Acc);
        false -> []
    end;
split_into_fibonacci_helper(S, Acc, Index) ->
    Len = length(S),
    lists:foldl(
        fun(I, Result) ->
            case Result of
                [] ->
                    Sub = lists:sublist(S, 1, I),
                    case try_parse_int(Sub) of
                        {ok, Num} ->
                            case length(Acc) < 2 of
                                true ->
                                    split_into_fibonacci_helper(lists:nthtail(I, S), [Num | Acc], Index + 1);
                                false ->
                                    case check_fibonacci(Num, lists:nth(1, Acc), lists:nth(2, Acc)) of
                                        true ->
                                            split_into_fibonacci_helper(lists:nthtail(I, S), [Num | Acc], Index + 1);
                                        false ->
                                            []
                                    end
                            end;
                        error ->
                            []
                    end;
                _ ->
                    Result
            end
        end,
        [],
        lists:seq(1, min(10, Len))
    ).

check_fibonacci(A, B, C) ->
    A =:= B + C.

try_parse_int(S) ->
    case string:to_integer(S) of
        {Int, _} when Int >= 0, Int =< 2147483647 ->
            case length(S) > 1 andalso lists:nth(1, S) == $0 of
                true -> error;
                false -> {ok, Int}
            end;
        _ ->
            error
    end.