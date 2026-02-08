-module(topVotedCandidate).
-export([new/2, q/2]).

-record(new_state, {
    votes = #{} :: map(),
    leader = -1 :: integer(),
    max_votes = -1 :: integer(),
    results = [] :: [{integer(), integer()}]
}).

new(Persons, Times) ->
    InitialState = #new_state{},
    FoldedState = lists:foldl(
        fun({P, T}, Acc) ->
            CurrentVotes = Acc#new_state.votes,
            CurrentLeader = Acc#new_state.leader,
            CurrentMaxVotes = Acc#new_state.max_votes,
            CurrentResults = Acc#new_state.results,

            NewCount = maps:get(P, CurrentVotes, 0) + 1,
            UpdatedVotes = maps:put(P, NewCount, CurrentVotes),

            {NextLeader, NextMaxVotes} =
                if NewCount >= CurrentMaxVotes -> {P, NewCount};
                   true -> {CurrentLeader, CurrentMaxVotes}
                end,

            UpdatedResults = [{T, NextLeader} | CurrentResults],

            Acc#new_state{
                votes = UpdatedVotes,
                leader = NextLeader,
                max_votes = NextMaxVotes,
                results = UpdatedResults
            }
        end,
        InitialState,
        lists:zip(Persons, Times)
    ),
    array:from_list(lists:reverse(FoldedState#new_state.results)).

q(This, T) ->
    q_bs(This, T, 0, array:size(This) - 1, 0).

q_bs(Array, T, Low, High, AnsIndex) ->
    if Low > High ->
        element(2, array:get(AnsIndex, Array));
    true ->
        Mid = Low + (High - Low) div 2,
        {MidTime, _} = array:get(Mid, Array),
        if MidTime =< T ->
            q_bs(Array, T, Mid + 1, High, Mid);
        true ->
            q_bs(Array, T, Low, Mid - 1, AnsIndex)
        end
    end.