-spec maximize_min_score(Nums :: [integer()], K :: integer()) -> integer().
maximize_min_score(Nums, K) ->
    N = length(Nums),
    case N rem 2 =/= 0 of
        true -> error("Nums must have even length");
        false -> ok
    end,
    lists:max([lists:min([lists:nth(I, Nums), lists:nth(J, Nums)]) || 
              I <- lists:seq(1, N div 2), 
              J <- lists:seq(N div 2 + 1, N)]).