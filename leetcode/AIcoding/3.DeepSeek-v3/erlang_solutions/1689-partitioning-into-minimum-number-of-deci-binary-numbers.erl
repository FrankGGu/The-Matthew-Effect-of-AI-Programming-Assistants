-spec min_partitions(N :: unicode:unicode_binary()) -> integer().
min_partitions(N) ->
    lists:max([ C - $0 || <<C>> <= N ]).