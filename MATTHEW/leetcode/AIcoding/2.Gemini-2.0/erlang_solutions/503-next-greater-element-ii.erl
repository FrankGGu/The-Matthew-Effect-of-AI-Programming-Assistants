-module(next_greater_element_ii).
-export([next_greater_elements/1]).

next_greater_elements(Nums) ->
    N = length(Nums),
    Result = lists:duplicate(N, -1),
    Stack = [],

    for(I = 0, I < 2 * N, I = I + 1) do
        Num = lists:nth(I rem N + 1, Nums),
        while Stack /= [] andalso Num > lists:nth(hd(Stack) + 1, Nums) do
            Index = hd(Stack),
            Stack1 = tl(Stack),
            Result ! Index = Num,
            Stack = Stack1
        end,
        if I < N then
            Stack = [I | Stack]
        else
            ok
        end
    end,
    lists:reverse(Result).