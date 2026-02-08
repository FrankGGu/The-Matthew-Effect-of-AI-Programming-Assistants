-module(longest_unequal_adjacent_groups_subsequence_i).
-export([length_of_luagis/1]).

length_of_luagis(G) ->
    length_of_luagis(G, []).

length_of_luagis([], Acc) ->
    length(Acc);
length_of_luagis([H | T], []) ->
    length_of_luagis(T, [H]);
length_of_luagis([H | T], [Prev | _] = Acc) ->
    if
        H /= Prev ->
            length_of_luagis(T, [H | Acc]);
        true ->
            length_of_luagis(T, Acc)
    end.