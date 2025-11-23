-spec num_rabbits(Answers :: [integer()]) -> integer().
num_rabbits(Answers) ->
    Counts = lists:foldl(fun(X, Acc) -> maps:update_with(X, fun(V) -> V + 1 end, 1, Acc) end, #{}, Answers),
    maps:fold(fun(K, V, Acc) -> 
                  GroupSize = K + 1,
                  Groups = (V + GroupSize - 1) div GroupSize,
                  Acc + Groups * GroupSize
              end, 0, Counts).