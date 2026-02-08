-module(fill_missing_data).
-export([solve/1]).

solve(Records) ->
  case Records of
    [] ->
      [];
    [H|T] ->
      solve(Records, []).

solve([], Acc) ->
  lists:reverse(Acc);
solve([{_, null}] = Records, Acc) ->
  case Acc of
    [] ->
      lists:reverse([{1, 0.0}|Acc]);
    [{_, LastValue}|_] ->
      lists:reverse([{length(Acc)+1, LastValue}|Acc]);

  solve(tl(Records), [{length(Acc)+1, LastValue}|Acc]);

solve([{Id, Value}|Records], Acc) ->
  solve(Records, [{Id, Value}|Acc]).