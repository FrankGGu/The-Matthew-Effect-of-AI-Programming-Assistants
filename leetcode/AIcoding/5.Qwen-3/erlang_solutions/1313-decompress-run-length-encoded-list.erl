-module(decompress_run_length_encoded_list).
-export([decompress_rle_list/1]).

decompress_rle_list([]) -> [];
decompress_rle_list([H|T]) ->
    decomp(H, T, []).

decomp(_, [], Acc) -> lists:reverse(Acc);
decomp(Count, [Val|Rest], Acc) ->
    decomp(Count - 1, Rest, [Val | Acc]).