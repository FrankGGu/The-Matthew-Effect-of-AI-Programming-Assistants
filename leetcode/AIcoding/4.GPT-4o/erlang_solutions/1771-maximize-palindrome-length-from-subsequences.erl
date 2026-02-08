-module(solution).
-export([longest_palindrome_subseq/1]).

longest_palindrome_subseq(Str) ->
    N = length(Str),
    D = lists:duplicate(N, lists:duplicate(N, 0)),
    lists:foldl(fun(X, Acc) ->
        lists:foldl(fun(Y, Acc2) ->
            case {X, Y} of
                {A, B} when A == B -> 
                    case {X, Y} of
                        {_, _} when X == Y -> 
                            Acc2#{{X, Y} => Acc2#{{X, Y}} + 1};
                        _ -> 
                            Acc2
                    end;
                _ -> 
                    Acc2
            end
        end, Acc, Str)
    end, D, Str),
    lists:max(D).