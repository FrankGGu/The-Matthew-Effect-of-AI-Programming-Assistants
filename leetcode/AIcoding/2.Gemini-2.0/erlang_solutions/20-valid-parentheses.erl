-module(valid_parentheses).
-export([is_valid/1]).

is_valid(S) ->
  is_valid(S, []).

is_valid([], []) ->
  true;
is_valid([], _) ->
  false;
is_valid([H|T], Stack) ->
  case H of
    $( ->
      is_valid(T, [$(|Stack]);
    $[ ->
      is_valid(T, $[|Stack]);
    ${ ->
      is_valid(T, ${|Stack]);
    $) ->
      case Stack of
        [$(|Rest)] ->
          is_valid(T, Rest);
        _ ->
          false
      end;
    $] ->
      case Stack of
        [$[|Rest)] ->
          is_valid(T, Rest);
        _ ->
          false
      end;
    $} ->
      case Stack of
        [${|Rest)] ->
          is_valid(T, Rest);
        _ ->
          false
      end;
    _ ->
      false
  end.