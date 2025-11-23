-module(sequential_ordinal_rank_tracker).
-export([new/0, add_score/2, get_rank_from_id/2]).

-record(state, {scores = #{}, sorted_scores = []}).

new() ->
    #state{}.

add_score(Id, Score, State) ->
    NewScores = maps:put(State#state.scores, Id, Score),
    NewSortedScores = lists:sort(fun({_Id1, Score1}, {_Id2, Score2}) -> Score1 >= Score2 end, maps:to_list(NewScores)),
    State#state{scores = NewScores, sorted_scores = NewSortedScores}.

get_rank_from_id(Id, State) ->
    get_rank_from_id_helper(Id, State#state.sorted_scores, 1).

get_rank_from_id_helper(_Id, [], _Rank) ->
    -1;
get_rank_from_id_helper(Id, [{Id, _Score} | _Rest], Rank) ->
    Rank;
get_rank_from_id_helper(Id, [{_OtherId, _Score} | Rest], Rank) ->
    get_rank_from_id_helper(Id, Rest, Rank + 1).