-spec query_string(S :: unicode:unicode_binary(), N :: integer()) -> boolean().
query_string(S, N) ->
    lists:all(fun(K) -> 
                  binary:match(S, [binary:encode_unsigned(K)]) =/= nomatch
              end, lists:seq(1, N)).