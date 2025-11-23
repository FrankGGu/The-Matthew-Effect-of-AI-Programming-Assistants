-module(solution).
-export([get_happy_string/2]).

get_happy_string(N, K) ->
    HappyStrings = generate_happy_strings(N, "", []),
    case lists:nth(K, HappyStrings) of
        undefined -> ""
        String -> String
    end.

generate_happy_strings(0, Current, Acc) ->
    [Current | Acc];
generate_happy_strings(N, Current, Acc) ->
    lists:foldl(fun(Char, Acc1) ->
        case Current of
            "" -> generate_happy_strings(N - 1, Char, Acc1);
            _ when lists:last(Current) =:= Char -> Acc1;
            _ -> generate_happy_strings(N - 1, Char, [Current | Acc1])
        end
    end, Acc, "abc").