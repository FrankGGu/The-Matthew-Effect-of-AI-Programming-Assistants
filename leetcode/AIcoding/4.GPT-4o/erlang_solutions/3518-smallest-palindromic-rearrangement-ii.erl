-module(solution).
-export([smallest_palindromic_rearrangement/1]).

smallest_palindromic_rearrangement(S) ->
    Freq = lists:foldl(fun(C, Acc) -> maps:update_with(C, fun(_) -> 1 end, fun(X) -> X + 1 end, Acc) end, maps:empty(), list_to_binary(S)),
    OddCount = maps:fold(fun(_, V, Acc) -> if V rem 2 =:= 1 -> Acc + 1; true -> Acc end end, 0, Freq),
    if OddCount > 1 -> ""; true -> build_palindrome(Freq) end.

build_palindrome(Freq) ->
    {Left, Mid, Right} = maps:fold(fun(Key, Value, {L, M, R}) ->
        Count = Value div 2,
        case Count of
            0 -> {L, M, R};
            _ -> 
                {L ++ lists:duplicate(Count, Key), M ++ (if Value rem 2 =:= 1 -> [Key]; true -> [] end), R ++ lists:duplicate(Count, Key)}
        end
    end, {[], [], []}, Freq),
    Left ++ Mid ++ lists:reverse(Right).