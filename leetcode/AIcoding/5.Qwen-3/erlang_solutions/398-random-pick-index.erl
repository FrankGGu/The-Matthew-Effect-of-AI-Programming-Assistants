-module(random_pick_index).
-export([new/1, pick_index/1]).

-record(state, {nums}).

new(Nums) ->
    #state{nums = Nums}.

pick_index(State) ->
    #state{nums = Nums} = State,
    Length = length(Nums),
    Index = rand:uniform(Length),
    lists:nth(Index, Nums).