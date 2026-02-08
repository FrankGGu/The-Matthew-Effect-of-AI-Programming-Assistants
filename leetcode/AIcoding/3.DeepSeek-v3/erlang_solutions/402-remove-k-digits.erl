-spec remove_kdigits(Num :: unicode:unicode_binary(), K :: integer()) -> unicode:unicode_binary().
remove_kdigits(Num, K) ->
    Stack = remove_kdigits(binary_to_list(Num), K, []),
    case Stack of
        [] -> <<"0">>;
        _ -> 
            Result = lists:reverse(Stack),
            case string:strip(Result, left, $0) of
                [] -> <<"0">>;
                Stripped -> list_to_binary(Stripped)
            end
    end.

remove_kdigits([], 0, Stack) -> Stack;
remove_kdigits([], K, Stack) -> lists:sublist(Stack, 1, length(Stack) - K);
remove_kdigits([H | T], K, Stack) when K > 0 ->
    case Stack of
        [] -> remove_kdigits(T, K, [H | Stack]);
        [Top | _] when H < Top -> remove_kdigits([H | T], K - 1, tl(Stack));
        _ -> remove_kdigits(T, K, [H | Stack])
    end;
remove_kdigits([H | T], K, Stack) -> remove_kdigits(T, K, [H | Stack]).