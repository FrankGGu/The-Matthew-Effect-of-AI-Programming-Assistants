-module(solution).
-export([odd_even_jump/1]).

odd_even_jump(A) ->
    N = length(A),
    Sorted = lists:sort(A),
    OddJump = lists:duplicate(N, false),
    EvenJump = lists:duplicate(N, false),
    OddJump1 = lists:foldl(fun(I, Acc) ->
        {Index, _} = lists:keyfind(I, 1, lists:zip(A, lists:seq(0, N - 1))),
        case Acc of
            [] -> [false];
            [H | T] -> 
                if
                    H -> [true | T];
                    true -> [true | T];
                    true -> [false | T]
                end
        end
    end, [], Sorted),
    EvenJump1 = lists:foldl(fun(I, Acc) ->
        {Index, _} = lists:keyfind(I, 1, lists:zip(A, lists:seq(0, N - 1))),
        case Acc of
            [] -> [false];
            [H | T] -> 
                if
                    H -> [true | T];
                    true -> [true | T];
                    true -> [false | T]
                end
        end
    end, [], Sorted),
    lists:foldl(fun(X, Acc) -> 
        case Acc of
            [] -> [0];
            _ -> 
                if
                    lists:nth(X + 1, OddJump1) -> [1 | Acc];
                    lists:nth(X + 1, EvenJump1) -> [1 | Acc]
                end
        end
    end, [], lists:seq(0, N - 1)).