-spec min_distance(Word1 :: unicode:unicode_binary(), Word2 :: unicode:unicode_binary()) -> integer().
min_distance(Word1, Word2) ->
    min_distance(length(Word1), length(Word2), Word1, Word2, #{}).

min_distance(0, 0, _, _, Acc) -> 
    maps:get({0, 0}, Acc);
min_distance(I, 0, Word1, _, Acc) -> 
    min_distance(I - 1, 0, Word1, "", maps:put({I, 0}, I, Acc));
min_distance(0, J, _, Word2, Acc) -> 
    min_distance(0, J - 1, "", Word2, maps:put({0, J}, J, Acc));
min_distance(I, J, Word1, Word2, Acc) when byte_size(Word1) > 0 andalso byte_size(Word2) > 0 ->
    if
        :erlang:byte_size(binary:part(Word1, {0, 1})) =:= :erlang:byte_size(binary:part(Word2, {0, 1})) ->
            min_distance(I - 1, J - 1, tl(Word1), tl(Word2), maps:put({I, J}, maps:get({I - 1, J - 1}, Acc) ,Acc));
        true -> 
            min_distance(I-1,J-)remlbsget("steps end and
