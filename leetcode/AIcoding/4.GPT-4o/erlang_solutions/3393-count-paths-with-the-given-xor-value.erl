-module(solution).
-export([count_paths/3]).

count_paths(Tree, Target, Xor) ->
    Paths = traverse(Tree, Xor, 0),
    lists:foldl(fun(X) -> if X =:= Target -> 1; true -> 0 end end, 0, Paths).

traverse(nil, _, _) -> [];
traverse({Value, Left, Right}, Xor, Acc) ->
    NewAcc = Acc bxor Value,
    [NewAcc | traverse(Left, Xor, NewAcc)] ++ traverse(Right, Xor, NewAcc).