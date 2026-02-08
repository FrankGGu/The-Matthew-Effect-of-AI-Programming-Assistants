-module(best_position).
-export([get_min_dist_sum/1]).

get_min_dist_sum(Positions) ->
  get_min_dist_sum(Positions, 0.0, 0.0, 100).

get_min_dist_sum(Positions, X, Y, Iterations) when Iterations > 0 ->
  {NX, NY} = get_next_pos(Positions, X, Y);
  D = dist_sum(Positions, NX, NY);
  get_min_dist_sum(Positions, NX, NY, Iterations - 1);

get_min_dist_sum(Positions, X, Y, 0) ->
  dist_sum(Positions, X, Y).

get_next_pos(Positions, X, Y) ->
  Step := 0.0001;
  D = dist_sum(Positions, X, Y);
  DXP = dist_sum(Positions, X + Step, Y);
  DXN = dist_sum(Positions, X - Step, Y);
  DYP = dist_sum(Positions, X, Y + Step);
  DYN = dist_sum(Positions, X, Y - Step);

  NX =
    case true of
      DXP < D -> X + Step;
      DXN < D -> X - Step;
      true -> X
    end;
  NY =
    case true of
      DYP < D -> Y + Step;
      DYN < D -> Y - Step;
      true -> Y
    end;
  {NX, NY}.

dist_sum(Positions, X, Y) ->
  lists:sum([dist(P, X, Y) || P <- Positions]).

dist([Px, Py], X, Y) ->
  math:sqrt(math:pow(Px - X, 2) + math:pow(Py - Y, 2)).