-module(palindrome_partitioning_iv).
-export([canBePalindrome/1]).

canBePalindrome(S) ->
    N = length(S),
    IsPal = fun(I, J) ->
        case I >= J of
            true -> true;
            false -> 
                case lists:nth(I+1, S) == lists:nth(J+1, S) of
                    true -> IsPal(I+1, J-1);
                    false -> false
                end
        end
    end,
    DP = array:new(N, {default, false}),
    DP2 = array:set(0, true, DP),
    lists:foldl(fun(I, Acc) ->
        case array:get(I, Acc) of
            true ->
                lists:foldl(fun(J, Acc2) ->
                    case J > I andalso IsPal(I+1, J-1) of
                        true -> array:set(J, true, Acc2);
                        false -> Acc2
                    end
                end, Acc, lists:seq(I+1, N-1));
            false -> Acc
        end
    end, DP2, lists:seq(0, N-1)).

canBePalindrome(S) ->
    N = length(S),
    DP = array:new(N, {default, false}),
    DP2 = array:set(0, true, DP),
    lists:foldl(fun(I, Acc) ->
        case array:get(I, Acc) of
            true ->
                lists:foldl(fun(J, Acc2) ->
                    case J > I andalso is_palindrome(S, I+1, J-1) of
                        true -> array:set(J, true, Acc2);
                        false -> Acc2
                    end
                end, Acc, lists:seq(I+1, N-1));
            false -> Acc
        end
    end, DP2, lists:seq(0, N-1)),
    array:get(N-1, DP2).

is_palindrome(S, I, J) ->
    case I >= J of
        true -> true;
        false ->
            case lists:nth(I+1, S) == lists:nth(J+1, S) of
                true -> is_palindrome(S, I+1, J-1);
                false -> false
            end
    end.