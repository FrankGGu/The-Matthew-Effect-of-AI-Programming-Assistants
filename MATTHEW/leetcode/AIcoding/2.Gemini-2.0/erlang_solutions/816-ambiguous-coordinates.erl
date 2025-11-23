-module(ambiguous_coordinates).
-export([ambiguous_coordinates/1]).

ambiguous_coordinates(S) ->
  Sub = string:substr(S, 2, string:length(S) - 2),
  N = string:length(Sub),
  Result = [
    X ++ "." ++ Y ||
      I <- lists:seq(1, N - 1),
      X1 = string:substr(Sub, 1, I),
      Y1 = string:substr(Sub, I + 1, N - I),
      X <- possible_numbers(X1),
      Y <- possible_numbers(Y1)
  ],
  ["(" ++ C ++ ")" || C <- Result].

possible_numbers(S) ->
  case is_valid(S) of
    true ->
      [S] ++ possible_decimals(S);
    false ->
      []
  end.

possible_decimals(S) ->
  N = string:length(S),
  [
    string:substr(S, 1, I) ++ "." ++ string:substr(S, I + 1, N - I) ||
      I <- lists:seq(1, N - 1),
      is_valid(string:substr(S, 1, I) ++ "." ++ string:substr(S, I + 1, N - I))
  ].

is_valid(S) ->
  case string:chr(S, 1) of
    0 ->
      case string:chr(S, string:length(S)) of
        0 ->
          string:equal(S, "0");
        _ ->
          string:find(S, ".", back) == nomatch orelse string:substr(S, string:length(S), 1) /= "0"
      end;
    _ ->
      string:find(S, ".", back) == nomatch orelse string:substr(S, string:length(S), 1) /= "0"
  end.