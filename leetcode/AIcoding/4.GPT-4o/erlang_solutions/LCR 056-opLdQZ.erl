-module(solution).
-export([find_target/2]).

find_target(Tree, Target) ->
    Values = get_values(Tree, []),
    find_two_sum(Values, Target).

get_values(nil, Acc) -> 
    Acc;
get_values({Value, Left, Right}, Acc) -> 
    get_values(Left, [Value | get_values(Right, Acc)]).

find_two_sum(Values, Target) ->
    lists:foldl(fun(X, Acc) -> 
        case lists:member(Target - X, Acc) of 
            true -> 
                true;
            false -> 
                [X | Acc]
        end
    end, [], Values) =:= true.