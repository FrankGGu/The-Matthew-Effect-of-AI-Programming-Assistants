-spec kth_grammar(N :: integer(), K :: integer()) -> integer().
kth_grammar(N, K) ->
    if
        N == 1 -> 0;
        true ->
            Parent = kth_grammar(N - 1, (K + 1) div 2),
            if
                Parent == 0 ->
                    if
                        K rem 2 == 1 -> 0;
                        true -> 1
                    end;
                true ->
                    if
                        K rem 2 == 1 -> 1;
                        true -> 0
                    end
            end
    end.