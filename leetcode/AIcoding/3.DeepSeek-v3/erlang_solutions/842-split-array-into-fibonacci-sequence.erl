-module(solution).
-export([split_into_fibonacci/1]).

split_into_fibonacci(S) ->
    N = length(S),
    MaxNum = 2147483647,
    case N < 3 of
        true -> [];
        false ->
            lists:foldl(fun(_, Acc) ->
                case Acc =/= [] of
                    true -> Acc;
                    false ->
                        lists:foldl(fun(_, Acc1) ->
                            case Acc1 =/= [] of
                                true -> Acc1;
                                false ->
                                    try_fib(S, N, MaxNum)
                            end
                        end, [], lists:seq(1, N - 2))
                end
            end, [], lists:seq(1, N - 2))
    end.

try_fib(S, N, MaxNum) ->
    case get_num(S, 1, 1) of
        {error, _} -> [];
        {ok, Num1} ->
            case get_num(S, 2, 1) of
                {error, _} -> [];
                {ok, Num2} ->
                    Fib = [Num1, Num2],
                    case build_fib(S, N, 3, Fib, MaxNum) of
                        {ok, Res} -> Res;
                        {error, _} -> []
                    end
            end
    end.

get_num(S, Start, Len) ->
    case Start + Len - 1 > length(S) of
        true -> {error, invalid};
        false ->
            Sub = string:sub_string(S, Start, Start + Len - 1),
            case Sub of
                "0" -> {ok, 0};
                _ ->
                    case hd(Sub) =:= $0 of
                        true -> {error, invalid};
                        false ->
                            case string:to_integer(Sub) of
                                {Num, []} when Num =< 2147483647 -> {ok, Num};
                                _ -> {error, invalid}
                            end
                    end
            end
    end.

build_fib(S, N, Pos, Fib, MaxNum) ->
    case Pos > N of
        true -> {ok, Fib};
        false ->
            Len = length(Fib),
            Next = lists:nth(Len, Fib) + lists:nth(Len - 1, Fib),
            if
                Next > MaxNum -> {error, overflow};
                true ->
                    NextStr = integer_to_list(Next),
                    NextLen = length(NextStr),
                    case Pos + NextLen - 1 =< N of
                        false -> {error, invalid};
                        true ->
                            Sub = string:sub_string(S, Pos, Pos + NextLen - 1),
                            case Sub =:= NextStr of
                                true -> build_fib(S, N, Pos + NextLen, Fib ++ [Next], MaxNum);
                                false -> {error, invalid}
                            end
                    end
            end
    end.