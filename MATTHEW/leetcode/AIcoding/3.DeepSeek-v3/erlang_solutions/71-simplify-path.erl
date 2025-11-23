-module(solution).
-export([simplify_path/1]).

simplify_path(Path) ->
    Tokens = string:tokens(Path, "/"),
    Stack = lists:foldl(fun
        ("..", Acc) -> case Acc of [] -> []; _ -> tl(Acc) end;
        (".", Acc) -> Acc;
        (Token, Acc) when Token =/= "" -> [Token | Acc];
        (_, Acc) -> Acc
    end, [], Tokens),
    "/" ++ string:join(lists:reverse(Stack), "/").