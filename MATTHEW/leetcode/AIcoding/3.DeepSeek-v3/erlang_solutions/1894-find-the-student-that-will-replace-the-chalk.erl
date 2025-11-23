-spec chalk_replacer(Chalk :: [integer()], K :: integer()) -> integer().
chalk_replacer(Chalk, K) ->
    Sum = lists:sum(Chalk),
    Rem = K rem Sum,
    find_replacer(Chalk, Rem, 0).

find_replacer([H|T], Rem, Index) ->
    if
        Rem < H -> Index;
        true -> find_replacer(T, Rem - H, Index + 1)
    end.