-module(brainpower).
-export([solve_questions/1]).

solve_questions(Questions) ->
  solve_questions(Questions, []).

solve_questions([], Acc) ->
  lists:max([0 | Acc]);
solve_questions([H|T], Acc) ->
  [Points, Brainpower] = H,
  N = length(Acc),
  NewAcc =
    case N < length(T) + 1 of
      true ->
        Acc ++ [0];
      false ->
        Acc
    end,
  solve_questions(T, update_acc(NewAcc, Points, Brainpower, N)).

update_acc(Acc, Points, Brainpower, N) ->
  case N of
    0 ->
      [Points | Acc];
    _ ->
      Acc1 = lists:nth(N, Acc),
      Acc2 = max(Points + Acc1, Acc1),
      NewAcc = lists:nthtail(N, Acc),
      case NewAcc of
        [] ->
          lists:prefix(N, Acc) ++ [Acc2];
        _ ->
          lists:prefix(N, Acc) ++ [Acc2]
      end
  end,

  Index = N + Brainpower + 1,

  case Index > length(Acc) of
    true ->
      Acc;
    false ->
      OldValue = lists:nth(Index, Acc),
      NewValue = lists:nth(N, Acc),
      UpdatedAcc = lists:nthtail(Index, Acc),

      case UpdatedAcc of
        [] ->
          Acc;
        _ ->
          case NewValue > OldValue of
            true ->
              lists:prefix(Index - 1, Acc) ++ [NewValue] ++ lists:nthtail(Index, Acc);
            false ->
              Acc
          end
      end
  end.