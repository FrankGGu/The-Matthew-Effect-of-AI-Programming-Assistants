-module(solution).
-export([visible_people/1]).

visible_people(People) ->
    N = length(People),
    Result = lists:duplicate(N, 0),
    Stack = [],
    visible_people(People, 0, Stack, Result).

visible_people([], _, _, Result) ->
    Result;
visible_people([H | T], I, Stack, Result) ->
    while true do
        case Stack of
            [] -> 
                NewStack = [H],
                visible_people(T, I + 1, NewStack, Result);
            [P | _] when P < H ->
                Result2 = lists:sublist(Result, I) ++ [lists:nth(I + 1, Result) + 1] ++ lists:nthtail(I + 2, Result),
                NewStack = [H | lists:taketail(Stack)],
                visible_people(T, I + 1, NewStack, Result2);
            _ ->
                Result2 = lists:sublist(Result, I) ++ [lists:nth(I + 1, Result) + 1] ++ lists:nthtail(I + 2, Result),
                visible_people(T, I + 1, [H | Stack], Result2)
        end
    end.