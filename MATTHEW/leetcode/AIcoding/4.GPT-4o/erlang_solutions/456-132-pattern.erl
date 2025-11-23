-module(solution).
-export([find132pattern/1]).

-spec find132pattern([integer()]) -> boolean().
find132pattern(Nums) ->
    find132pattern(Nums, [], inf).

%% Helper function with stack and third number initialized to infinity
find132pattern([], _, _) -> false;
find132pattern([H | T], Stack, Third) ->
    case Stack of
        [] -> find132pattern(T, [H], Third);
        [S | _] when S < H -> find132pattern(T, [H | Stack], Third);
        [S | _] when S > H -> 
            case Third < S of
                true -> true;
                false -> find132pattern(T, Stack, min(S, Third))
            end;
    end.

%% Test case for calling the function:
%% solution:find132pattern([3,1,4,2]).
