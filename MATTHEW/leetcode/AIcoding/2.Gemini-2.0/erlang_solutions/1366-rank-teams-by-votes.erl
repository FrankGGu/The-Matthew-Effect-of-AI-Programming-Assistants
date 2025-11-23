-module(rank_teams_by_votes).
-export([rank_teams/1]).

rank_teams(Votes) ->
  lists:sort(fun(A, B) -> compare_teams(A, B, Votes) end, get_teams(Votes)).

get_teams(Votes) ->
  lists:usort(lists:flatten([string:characters(V) || V <- Votes])).

compare_teams(A, B, Votes) ->
  compare_teams_helper(A, B, Votes, 0).

compare_teams_helper(A, B, Votes, Index) ->
  case lists:nth(1, get_votes_at_index(A, Votes, Index)) > lists:nth(1, get_votes_at_index(B, Votes, Index)) of
    true -> true;
    false ->
      case lists:nth(1, get_votes_at_index(A, Votes, Index)) < lists:nth(1, get_votes_at_index(B, Votes, Index)) of
        true -> false;
        false ->
          case Index < string:len(hd(Votes)) - 1 of
            true -> compare_teams_helper(A, B, Votes, Index + 1);
            false -> A < B
          end
      end
  end.

get_votes_at_index(Team, Votes, Index) ->
  lists:foldl(fun(Vote, Acc) ->
                    case string:nth(Index, Vote) == Team of
                      true -> [{Team, lists:nth(2, lists:keyfind(Team, 1, Acc)) + 1}];
                      false -> Acc
                    end
                end, [{Team, 0}], Votes).