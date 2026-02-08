-spec find_lu_slength(A :: unicode:unicode_binary(), B :: unicode:unicode_binary()) -> integer().
find_lu_slength(A, B) ->
    case A =:= B of
        true -> -1;
        false -> max(byte_size(A), byte_size(B))
    end.