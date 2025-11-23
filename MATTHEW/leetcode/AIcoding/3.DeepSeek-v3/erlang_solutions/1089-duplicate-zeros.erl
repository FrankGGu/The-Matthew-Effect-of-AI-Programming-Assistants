-spec duplicate_zeros(Arr :: [integer()]) -> [integer()].
duplicate_zeros(Arr) ->
    duplicate_zeros(Arr, []).

duplicate_zeros([], Acc) ->
    lists:reverse(Acc);
duplicate_zeros([0 | Rest], Acc) ->
    duplicate_zeros(Rest, [0, 0 | Acc]);
duplicate_zeros([X | Rest], Acc) ->
    duplicate_zeros(Rest, [X | Acc]).