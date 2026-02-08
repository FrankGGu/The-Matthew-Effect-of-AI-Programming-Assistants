-spec rotated_digits(N :: integer()) -> integer().
rotated_digits(N) ->
    lists:foldl(fun(X, Acc) ->
        case is_good(X) of
            true -> Acc + 1;
            false -> Acc
        end
    end, 0, lists:seq(1, N)).

is_good(N) ->
    Digits = integer_to_list(N),
    lists:all(fun(D) -> lists:member(D, "0182569") end, Digits) andalso
    lists:any(fun(D) -> lists:member(D, "2569") end, Digits).