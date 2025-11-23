-spec merge_alternately(Word1 :: string(), Word2 :: string()) -> string().
merge_alternately(Word1, Word2) ->
    do_merge(Word1, Word2).

do_merge([], []) ->
    [];
do_merge([], Word2) ->
    Word2;
do_merge(Word1, []) ->
    Word1;
do_merge([H1|T1], [H2|T2]) ->
    [H1, H2 | do_merge(T1, T2)].