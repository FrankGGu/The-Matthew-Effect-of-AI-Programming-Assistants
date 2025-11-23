-module(solution).
-export([find_occurences/3]).

find_occurences(W1, W2, W) ->
    find_occurences(W1, W2, W, [], []).

find_occurences(_, _, [], Acc, Result) ->
    lists:reverse(Result);
find_occurences(W1, W2, [H | T], Acc, Result) ->
    case Acc of
        [A, B | _] when A =:= W1, B =:= W2 ->
            find_occurences(W1, W2, T, [H | Acc], [H | Result]);
        _ ->
            find_occurences(W1, W2, T, [H | Acc], Result)
    end.