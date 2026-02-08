-spec guess_number(N :: integer()) -> integer().
guess_number(N) ->
    binary_search(1, N).

binary_search(Left, Right) ->
    Mid = Left + (Right - Left) div 2,
    case guess(Mid) of
        0 -> Mid;
        -1 -> binary_search(Left, Mid - 1);
        1 -> binary_search(Mid + 1, Right)
    end.