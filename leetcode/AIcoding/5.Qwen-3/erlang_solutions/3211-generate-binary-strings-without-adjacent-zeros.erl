-module(generate_binary_strings_without_adjacent_zeros).
-export([generate/1]).

generate(N) ->
    generate(N, []).

generate(0, Acc) ->
    lists:reverse(Acc);
generate(N, Acc) ->
    case Acc of
        [] ->
            generate(N-1, ["0"]);
        _ ->
            Last = lists:last(Acc),
            case Last of
                "0" ->
                    generate(N-1, Acc ++ ["1"]);
                "1" ->
                    generate(N-1, Acc ++ ["0"])
            end
    end.