-module(town_judge).
-export([findJudge/1]).

findJudge(N, Trust) ->
  InDegrees = lists:map(fun({_, B}) -> B end, Trust),
  OutDegrees = lists:map(fun({A, _}) -> A end, Trust),

  PotentialJudges = lists:seq(1, N) -- OutDegrees,

  find_judge(PotentialJudges, InDegrees, N).

find_judge([Judge], InDegrees, N) ->
  case lists:all(fun(Person) -> Person == Judge orelse lists:member(Judge, lists:filter(fun(X) -> X /= Judge end, InDegrees)) end, lists:seq(1, N)) of
    true -> Judge;
    false -> -1
  end;
find_judge([], _, _) -> -1;
find_judge(_, _, _) -> -1.

findJudge(N) when N == 1 -> 1;
findJudge(N, Trust) ->
    InDegrees = lists:seq(1,N),
    OutDegrees = lists:usort([A || {A,_} <- Trust]),
    PotentialJudges = InDegrees -- OutDegrees,
    case PotentialJudges of
        [Judge] ->
            TrustedByOthers = lists:all(fun(Person) -> lists:member({Person, Judge}, Trust) end, lists:seq(1, N) -- [Judge]),
            if TrustedByOthers -> Judge;
               true -> -1
            end;
        _ -> -1
    end.