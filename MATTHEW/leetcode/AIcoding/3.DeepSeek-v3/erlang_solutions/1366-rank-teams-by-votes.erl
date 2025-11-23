-spec rank_teams(Votes :: [unicode:unicode_binary()]) -> unicode:unicode_binary().
rank_teams(Votes) ->
    case Votes of
        [] -> <<>>;
        _ ->
            Teams = lists:usort(lists:concat([binary_to_list(V) || V <- Votes])),
            NumTeams = length(Teams),
            TeamIndices = lists:zip(Teams, lists:seq(0, NumTeams - 1)),
            TeamIndexMap = maps:from_list(TeamIndices),
            Counts = lists:foldl(fun(Vote, Acc) ->
                lists:foldl(fun(Team, InnerAcc) ->
                    Index = maps:get([Team], TeamIndexMap),
                    lists:sublist(InnerAcc, 1, Index) ++ 
                    [lists:nth(Index + 1, InnerAcc) + 1] ++ 
                    lists:nthtail(Index + 1, InnerAcc)
                end, Acc, binary_to_list(Vote))
            end, lists:duplicate(NumTeams, 0), Votes),
            TeamCounts = lists:zip(Teams, Counts),
            Sorted = lists:sort(fun({A, CountA}, {B, CountB}) ->
                case CountA == CountB of
                    true -> A =< B;
                    false -> CountA >= CountB
                end
            end, TeamCounts),
            list_to_binary([Team || {Team, _} <- Sorted])
    end.