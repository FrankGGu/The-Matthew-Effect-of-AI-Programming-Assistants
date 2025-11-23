-module(solution).
-export([generate_the_string/1]).

generate_the_string(N) ->
    generate_the_string(N, []).

generate_the_string(0, Acc) ->
    lists:reverse(Acc);
generate_the_string(N, Acc) ->
    case N rem 2 of
        1 ->
            generate_the_string(N - 1, [$. | Acc]);
        _ ->
            generate_the_string(N - 2, [$a, $a | Acc])
    end.