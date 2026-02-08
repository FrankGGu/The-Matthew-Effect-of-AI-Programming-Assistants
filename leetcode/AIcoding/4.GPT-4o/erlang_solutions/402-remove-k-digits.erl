-module(solution).
-export([remove_kdigits/2]).

-spec remove_kdigits(unicode:unicode_binary(), integer()) -> unicode:unicode_binary().
remove_kdigits(Num, K) ->
    remove_kdigits(Num, K, []).

-spec remove_kdigits(unicode:unicode_binary(), integer(), list()) -> unicode:unicode_binary().
remove_kdigits(<<>>, _, Result) -> lists:reverse(Result);
remove_kdigits(Num, 0, Result) -> lists:reverse(Result) ++ Num;
remove_kdigits(<<First:8, Rest/binary>>, K, Result) when K > 0 ->
    case Result of
        [] -> remove_kdigits(Rest, K, [First]);
        [Last | _] when Last > First -> remove_kdigits(Rest, K - 1, tl(Result));
        _ -> remove_kdigits(Rest, K, [First | Result])
    end.
