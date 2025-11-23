-module(online_election).
-export([q/1, init/1]).

init(Polls) ->
    Votes = lists:foldl(fun({Voter, Candidate}, Acc) ->
        maps:update_with(Candidate, fun(Count) -> Count + 1 end, 1, Acc)
    end, #{}, Polls),
    Candidates = lists:usort([C || {_, C} <- Polls]),
    {Votes, Candidates}.

q(T) ->
    {Votes, Candidates} = init([]),
    {_, Winner} = lists:foldl(fun(Candidate, {MaxCount, MaxCandidate}) ->
        Count = maps:get(Candidate, Votes, 0),
        if
            Count > MaxCount -> {Count, Candidate};
            true -> {MaxCount, MaxCandidate}
        end
    end, {0, hd(Candidates)}, Candidates),
    Winner.