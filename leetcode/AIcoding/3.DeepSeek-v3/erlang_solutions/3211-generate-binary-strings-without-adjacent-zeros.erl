-spec generate_binary_strings(N :: integer()) -> [string()].
generate_binary_strings(N) ->
    generate(N, []).

generate(0, Acc) ->
    [lists:reverse(Acc)];
generate(N, Acc) ->
    case Acc of
        [] -> 
            generate(N - 1, [$1 | Acc]) ++ generate(N - 1, [$0 | Acc]);
        [$1 | _] -> 
            generate(N - 1, [$1 | Acc]) ++ generate(N - 1, [$0 | Acc]);
        [$0 | _] -> 
            generate(N - 1, [$1 | Acc])
    end.