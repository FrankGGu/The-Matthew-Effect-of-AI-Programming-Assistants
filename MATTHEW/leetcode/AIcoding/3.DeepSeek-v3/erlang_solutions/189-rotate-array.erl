-spec rotate(Nums :: [integer()], K :: integer()) -> [integer()].
rotate(Nums, K) ->
    Len = length(Nums),
    if 
        Len == 0 -> Nums;
        true ->
            Rot = K rem Len,
            {Left, Right} = lists:split(Len - Rot, Nums),
            Right ++ Left
    end.