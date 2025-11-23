-module(job_scheduling).
-export([job_scheduling/2]).

job_scheduling(StartTime, EndTime, Profit) ->
  Jobs = lists:zip3(StartTime, EndTime, Profit),
  SortedJobs = lists:keysort(2, Jobs),
  N = length(Jobs),
  dp(SortedJobs, N, []).

dp(Jobs, 0, Acc) ->
  lists:reverse(Acc);
dp(Jobs, N, Acc) ->
  {Start, End, Profit} = lists:nth(N, Jobs),
  PrevIndex = find_prev_index(Jobs, N - 1, Start),
  ProfitWithJob = Profit + case PrevIndex of
                              -1 -> 0;
                              _ -> lists:nth(PrevIndex + 1, Acc)
                          end,
  ProfitWithoutJob = case Acc of
                         [] -> 0;
                         _ -> lists:nth(N, Acc)
                     end,
  case ProfitWithJob > ProfitWithoutJob of
    true -> dp(Jobs, N - 1, [ProfitWithJob | Acc]);
    false -> dp(Jobs, N - 1, [ProfitWithoutJob | Acc])
  end.

find_prev_index(Jobs, Index, Start) ->
  find_prev_index(Jobs, Index, Start, -1).

find_prev_index(_, -1, _, Acc) ->
  Acc;
find_prev_index(Jobs, Index, Start, Acc) ->
  {_, End, _} = lists:nth(Index + 1, Jobs),
  case End =< Start of
    true -> Index;
    false -> find_prev_index(Jobs, Index - 1, Start, Acc)
  end.