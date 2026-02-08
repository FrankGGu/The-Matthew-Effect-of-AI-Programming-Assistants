-module(solution).
-export([validate_token/2]).

validate_token(Token, Expected) ->
    TokenLen = length(Token),
    ExpectedLen = length(Expected),
    if 
        TokenLen =/= ExpectedLen ->
            false;
        true ->
            validate_token_helper(Token, Expected, 0)
    end.

validate_token_helper([], [], _) ->
    true;
validate_token_helper([H1 | T1], [H2 | T2], Index) ->
    if 
        H1 =/= H2 -> false;
        true -> validate_token_helper(T1, T2, Index + 1)
    end.