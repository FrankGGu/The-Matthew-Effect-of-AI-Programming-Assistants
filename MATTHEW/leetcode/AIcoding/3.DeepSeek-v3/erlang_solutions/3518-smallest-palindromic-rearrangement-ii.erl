-module(solution).
-export([smallest_palindrome/1]).

smallest_palindrome(S) ->
    Freq = lists:foldl(fun(C, Acc) -> 
                           maps:update_with(C, fun(V) -> V + 1 end, 1, Acc) 
                       end, #{}, S),
    case has_valid_palindrome(Freq) of
        false -> "";
        true -> build_palindrome(Freq)
    end.

has_valid_palindrome(Freq) ->
    OddCount = maps:fold(fun(_, V, Acc) -> 
                             case V rem 2 of
                                 1 -> Acc + 1;
                                 0 -> Acc
                             end
                         end, 0, Freq),
    OddCount =< 1.

build_palindrome(Freq) ->
    {Left, Middle, _} = maps:fold(fun
        (C, V, {L, M, R}) when V rem 2 =:= 1 -> 
            {L, [C], R};
        (C, V, {L, M, R}) -> 
            Half = V div 2,
            Chars = lists:duplicate(Half, C),
            {Chars ++ L, M, R ++ Chars}
    end, {[], [], []}, Freq),
    lists:flatten(Left ++ Middle ++ lists:reverse(Left)).