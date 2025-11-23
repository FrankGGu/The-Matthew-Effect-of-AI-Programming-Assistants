-spec str_without3a3b(A :: integer(), B :: integer()) -> unicode:unicode_binary().
str_without3a3b(A, B) ->
    build(A, B, $a, $b, <<>>).

build(A, B, X, Y, Acc) when A > B ->
    build(A, B, Y, X, Acc);
build(A, B, X, Y, Acc) ->
    case {A, B} of
        {0, 0} -> Acc;
        {A, B} when B >= 2 * A -> 
            case B - 2 of
                B1 when B1 >= 0 -> build(A, B1, X, Y, <<Acc/binary, Y, Y>>);
                _ -> build(A, 0, X, Y, <<Acc/binary, Y>>)
            end;
        {A, B} when B > 0 -> 
            build(A - 1, B - 1, X, Y, <<Acc/binary, X, Y>>);
        {A, 0} -> 
            build(A - 1, 0, X, Y, <<Acc/binary, X>>)
    end.