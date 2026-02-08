-spec make_smallest_palindrome(S :: unicode:unicode_binary()) -> unicode:unicode_binary().
make_smallest_palindrome(S) ->
    Bin = unicode:characters_to_binary(S),
    Size = byte_size(Bin),
    make_palindrome(Bin, Size, 0, Size - 1).

make_palindrome(Bin, Size, Left, Right) when Left >= Right ->
    Bin;
make_palindrome(Bin, Size, Left, Right) ->
    LeftChar = binary:at(Bin, Left),
    RightChar = binary:at(Bin, Right),
    if
        LeftChar < RightChar ->
            NewBin = binary:replace(Bin, <<RightChar>>, <<LeftChar>>, [{scope, {Right, 1}}]),
            make_palindrome(NewBin, Size, Left + 1, Right - 1);
        LeftChar > RightChar ->
            NewBin = binary:replace(Bin, <<LeftChar>>, <<RightChar>>, [{scope, {Left, 1}}]),
            make_palindrome(NewBin, Size, Left + 1, Right - 1);
        true ->
            make_palindrome(Bin, Size, Left + 1, Right - 1)
    end.