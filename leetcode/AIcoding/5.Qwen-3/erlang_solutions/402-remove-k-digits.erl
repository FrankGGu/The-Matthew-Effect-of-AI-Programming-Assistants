-module(remove_k_digits).
-export([remove_k_digits/2]).

remove_k_digits(Num, K) ->
    remove_k_digits(list_to_binary(Num), K, []).

remove_k_digits(<<>>, _, Result) ->
    case lists:reverse(Result) of
        [] -> "0";
        R -> binary_to_list(lists:foldl(fun(E, Acc) -> [E | Acc] end, [], R))
    end;
remove_k_digits(<<Digit, Rest/binary>>, K, Result) ->
    case Result of
        [] ->
            remove_k_digits(Rest, K, [Digit]);
        _ when K > 0 andalso hd(Result) > Digit ->
            remove_k_digits(<<Digit, Rest/binary>>, K - 1, tl(Result));
        _ ->
            remove_k_digits(Rest, K, [Digit | Result])
    end.