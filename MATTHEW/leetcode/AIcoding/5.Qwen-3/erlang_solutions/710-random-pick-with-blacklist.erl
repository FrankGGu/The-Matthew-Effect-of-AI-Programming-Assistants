-module(random_pick_with_blacklist).
-export([new/2, pick/1]).

new( N, Blacklist ) ->
    B = sets:from_list(Blacklist),
    Size = sets:size(B),
    {N, B, Size}.

pick( {N, B, Size} ) ->
    Rand = rand:uniform(N),
    if
        sets:is_element(Rand, B) ->
            pick( {N, B, Size} );
        true ->
            Rand
    end.