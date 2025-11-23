-module(substring_matching_pattern).
-export([solve/2]).

solve(Pattern, Value) ->
  solve(Pattern, Value, []).

solve([], Value, Acc) ->
  case Value of
    [] ->
      lists:reverse(Acc);
    _ ->
      []
  end;
solve([P|Ps], Value, Acc) ->
  case P of
    0 ->
      {Prefix, Suffix} = split(Value),
      case Prefix of
        [] ->
          solve(Ps, Value, Acc);
        _ ->
          solve(Ps, Suffix, [Prefix|Acc])
      end;
    _ ->
      []
  end.

split(Value) ->
  split(Value, []).

split([], Acc) ->
  {lists:reverse(Acc), []};
split([H|T], Acc) ->
  {lists:reverse(Acc), [H|T]}.