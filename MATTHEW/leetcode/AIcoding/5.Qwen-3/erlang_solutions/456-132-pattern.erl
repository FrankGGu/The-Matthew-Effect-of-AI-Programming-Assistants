-module(solve).
-export([find132/1]).

find132(Nums) ->
    Len = length(Nums),
    if
        Len < 3 -> false;
        true ->
            Stack = [],
            Third = -infinity,
            find132(Nums, Len, 0, Stack, Third)
    end.

find132(_, _, I, _, _) when I >= 0 ->
    false;
find132(Nums, Len, I, Stack, Third) ->
    [N | Rest] = lists:nth(I + 1, Nums),
    case N < Third of
        true -> true;
        false ->
            NewStack = case Stack of
                [] -> [N];
                [H | T] when N < H -> [N | Stack];
                _ -> [N | Stack]
            end,
            NewThird = case Stack of
                [H | _] when N > H -> H;
                _ -> Third
            end,
            find132(Nums, Len, I + 1, NewStack, NewThird)
    end.