-spec split_string(S :: unicode:unicode_binary()) -> boolean().
split_string(S) ->
    N = byte_size(S),
    split(S, 0, N, undefined).

split(_, Start, N, _) when Start >= N -> true;
split(S, Start, N, Prev) ->
    lists:any(fun(End) ->
        case binary_to_integer(binary:part(S, Start, End - Start)) of
            Num when Prev =:= undefined ->
                split(S, End, N, Num);
            Num when Prev - Num =:= 1 ->
                split(S, End, N, Num);
            _ ->
                false
        end
    end, lists:seq(Start + 1, N)).

binary_to_integer(Bin) ->
    list_to_integer(binary_to_list(Bin)).