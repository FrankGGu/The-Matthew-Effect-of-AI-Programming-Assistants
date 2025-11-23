-module(solution).
-export([next_greater_element/1]).

next_greater_element(List) ->
    N = length(List),
    NextGreater = lists:duplicate(N, -1),
    Stack = [],
    find_next_greater(List, lists:seq(0, N-1), NextGreater, Stack).

find_next_greater(_, [], NextGreater, _) ->
    NextGreater;
find_next_greater(List, [Index | Rest], NextGreater, Stack) ->
    NewStack = lists:foldl(fun(I, S) ->
        if
            lists:nth(I + 1, List) > lists:nth(Index + 1, List) ->
                NextGreater = lists:replace_at(NextGreater, I, lists:nth(Index + 1, List)),
                S
            ;
                S
        end
    end, Stack, lists:reverse(Stack)),
    find_next_greater(List, Rest, NewStack, [Index | NewStack]).