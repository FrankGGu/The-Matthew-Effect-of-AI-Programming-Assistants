-module(seq_ord_rank_tracker).
-export([init/0, add/2, get/1]).

-record(place, {name :: string(), score :: integer()}).

init() ->
    {[], []}.

add(Name, Score, {Left, Right}) ->
    Place = #place{name=Name, score=Score},
    case Left of
        [] -> {[Place], Right};
        _ ->
            case lists:keyfind(Score, #place.score, Left) of
                false ->
                    {lists:keymerge(#place.score, [Place], Left), Right};
                _ ->
                    NewLeft = lists:keymerge(#place.name, [Place], Left),
                    {NewLeft, Right}
            end
    end.

get(K, {Left, Right}) ->
    case length(Left) >= K of
        true ->
            {Name, NewLeft} = lists:nthtail(K-1, Left),
            {Name, {NewLeft, Right}};
        false ->
            get(K - length(Left), {Right, []})
    end.