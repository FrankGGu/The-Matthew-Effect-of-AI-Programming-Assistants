-spec optimal_division(Nums :: [integer()]) -> unicode:unicode_binary().
optimal_division(Nums) ->
    case length(Nums) of
        1 -> integer_to_binary(hd(Nums));
        2 -> 
            A = hd(Nums),
            B = hd(tl(Nums)),
            <<A/binary, "/", B/binary>>;
        _ ->
            [First | Rest] = Nums,
            RestStr = string:join([integer_to_binary(X) || X <- Rest], "/"),
            <<First/binary, "/(", RestStr/binary, ")">>
    end.