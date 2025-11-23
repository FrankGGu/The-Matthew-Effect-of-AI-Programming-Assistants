-module(solution).
-export([getHappyString/2]).

getHappyString(N, K) ->
    HappyStrings = generate_happy_strings(N),
    case length(HappyStrings) >= K of
        true -> lists:nth(K, HappyStrings);
        false -> ""
    end.

generate_happy_strings(N) ->
    Chars = [$a, $b, $c],
    generate(Chars, N, []).

generate(Chars, 0, Acc) ->
    [lists:reverse(Acc)];
generate(Chars, N, []) ->
    lists:flatmap(fun(C) -> generate(Chars, N - 1, [C]) end, Chars);
generate(Chars, N, [H | _] = Acc) ->
    lists:flatmap(
        fun(C) ->
            case C =/= H of
                true -> generate(Chars, N - 1, [C | Acc]);
                false -> []
            end
        end,
        Chars
    ).