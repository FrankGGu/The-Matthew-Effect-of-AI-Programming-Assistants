-spec minimum_recolors(Blocks :: unicode:unicode_binary(), K :: integer()) -> integer().
minimum_recolors(Blocks, K) ->
    B = unicode:characters_to_list(Blocks),
    N = length(B),
    MinRecolors = lists:min([count_whites(B, I, K) || I <- lists:seq(0, N - K)]),
    MinRecolors.

count_whites(B, Start, K) ->
    Sub = lists:sublist(B, Start + 1, K),
    length([C || C <- Sub, C =:= $W]).