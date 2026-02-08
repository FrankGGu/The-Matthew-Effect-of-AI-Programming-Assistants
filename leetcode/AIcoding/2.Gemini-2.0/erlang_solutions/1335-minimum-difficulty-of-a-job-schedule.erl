-module(job_scheduling).
-export([min_difficulty/2]).

min_difficulty(JobDifficulty, D) ->
  N = length(JobDifficulty),
  if N < D then
    -1
  else
    memo(JobDifficulty, D)
  end.

memo(JobDifficulty, D) ->
  N = length(JobDifficulty),
  DP = array:new([N + 1, D + 1], {fixed, infinity}),
  array:set({N, 0}, 0, DP),

  lists:foreach(fun(I) ->
                  lists:foreach(fun(J) ->
                                  if J > 0 then
                                    MaxDifficulty = -1,
                                    for(K = I; K >= 1; K = K - 1) do
                                      MaxDifficulty = max(MaxDifficulty, lists:nth(K, JobDifficulty)),
                                      Prev = array:get({K - 1, J - 1}, DP),
                                      array:set({I, J}, min(array:get({I, J}, DP), Prev + MaxDifficulty), DP)
                                    end
                                  end
                                 end, lists:seq(0, D))
                 end, lists:seq(1, N)),
  array:get({N, D}, DP).

min(A, B) ->
  if A < B then A else B end.

max(A, B) ->
  if A > B then A else B end.

for(Start, End, Fun) ->
  lists:foreach(Fun, lists:seq(Start, End)).