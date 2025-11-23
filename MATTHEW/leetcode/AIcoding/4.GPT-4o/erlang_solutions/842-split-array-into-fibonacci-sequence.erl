-module(solution).
-export([split_into_fibonacci/1]).

split_into_fibonacci(S) ->
    split_into_fibonacci(S, [], 0).

split_into_fibonacci([], Acc, _) ->
    Acc;
split_into_fibonacci(S, Acc, Pre) ->
    case find_fib(S, Pre, "", Acc) of
        {ok, NewAcc} -> NewAcc;
        _ -> []
    end.

find_fib([], _, _, _) -> {error, no_fib};
find_fib(S, Pre, Cur, Acc) ->
    case Cur of
        "" -> find_fib(S, Pre, get_next(S), Acc);
        _ ->
            case lists:prefix(S, Cur) of
                true ->
                    NewPre = lists:foldl(fun(X, Acc) -> Acc + X end, 0, string:to_integer(Cur)) + Pre,
                    NewAcc = Acc ++ [string:to_integer(Cur)],
                    find_fib(lists:substring(S, length(Cur)), NewPre, "", NewAcc);
                false -> {error, no_fib}
            end
    end.

get_next(S) ->
    case string:to_integer(S) of
        {error, _} -> "";
        {ok, N} -> integer_to_list(N)
    end.