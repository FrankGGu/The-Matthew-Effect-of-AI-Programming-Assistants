-module(p132).
-export([min_cut/1]).

min_cut(S) ->
    N = erlang:length(S),
    DP = array:new(N, {default, 0}),
    IsPalindrome = array:new(N, {default, array:new(N, {default, false})}),
    init_is_palindrome(IsPalindrome, S),
    min_cut_helper(S, N, DP, IsPalindrome).

init_is_palindrome(IsPalindrome, S) ->
    N = erlang:length(S),
    init_is_palindrome(IsPalindrome, S, 0, N - 1).

init_is_palindrome(IsPalindrome, S, I, J) when I > J -> ok;
init_is_palindrome(IsPalindrome, S, I, J) ->
    case is_palindrome(S, I, J) of
        true -> array:set({I, J}, true, IsPalindrome);
        false -> IsPalindrome
    end,
    init_is_palindrome(IsPalindrome, S, I + 1, J).

is_palindrome(S, I, J) ->
    case I == J of
        true -> true;
        false ->
            case I + 1 == J of
                true -> erlang:element(I + 1, S) == erlang:element(J + 1, S);
                false -> erlang:element(I + 1, S) == erlang:element(J + 1, S) andalso is_palindrome(S, I + 1, J - 1)
            end
    end.

min_cut_helper(S, N, DP, IsPalindrome) ->
    min_cut_helper(S, N, DP, IsPalindrome, 0).

min_cut_helper(S, N, DP, IsPalindrome, I) when I == N -> -1;
min_cut_helper(S, N, DP, IsPalindrome, I) ->
    case array:get(I, DP) of
        Val when Val /= 0 -> Val;
        _ ->
            Min = min_cut_helper(S, N, DP, IsPalindrome, I + 1),
            Res = case Min of
                      -1 -> 0;
                      _ -> Min + 1
                  end,
            lists:foldl(fun(J, Acc) ->
                                if
                                    J >= N -> Acc;
                                    true ->
                                        case array:get(J, DP) of
                                            Val when Val /= 0 ->
                                                if
                                                    is_palindrome(S, I, J) -> min(Acc, Val + 1);
                                                    true -> Acc
                                                end;
                                            _ ->
                                                if
                                                    is_palindrome(S, I, J) -> min(Acc, min_cut_helper(S, N, DP, IsPalindrome, J + 1) + 1);
                                                    true -> Acc
                                                end
                                        end
                                end
                            end, Res, lists:seq(I, N - 1)),
            array:set(I, Res, DP),
            Res
    end.

min(A, B) when A < B -> A;
min(_, B) -> B.