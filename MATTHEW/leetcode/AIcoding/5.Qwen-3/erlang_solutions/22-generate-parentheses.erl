-module(generate_parentheses).
-export([generate_parentheses/1]).

generate_parentheses(N) ->
    generate(N, 0, 0, [], []).

generate(_, _, _, _, Result) when length(Result) == factorial(N) -> Result;
generate(N, Open, Close, Current, Result) ->
    case Open < N of
        true ->
            generate(N, Open + 1, Close, [$( | Current], Result);
        false ->
            case Close < Open of
                true ->
                    generate(N, Open, Close + 1, [$) | Current], Result);
                false ->
                    generate(N, Open, Close, Current, [lists:reverse(Current) | Result])
            end
    end.

factorial(0) -> 1;
factorial(N) -> N * factorial(N - 1).