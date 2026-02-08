-spec max_operations(Binary :: unicode:unicode_binary()) -> integer().
max_operations(Binary) ->
    Ones = [1 || <<"1">> <= Binary],
    Zeroes = [0 || <<"0">> <= Binary],
    lists:min([length(Ones), length(Zeroes)]).