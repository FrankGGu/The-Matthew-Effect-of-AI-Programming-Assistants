-module(pascals_triangle).
-export([generate/1]).

generate(NumRows) ->
  generate_helper(NumRows, []).

generate_helper(0, Acc) ->
  lists:reverse(Acc);
generate_helper(N, Acc) ->
  Row = case Acc of
          [] -> [1];
          [PrevRow|_] -> [1 | next_row(PrevRow, [])]
        end,
  generate_helper(N - 1, [Row | Acc]).

next_row([_], Acc) ->
  lists:reverse([1 | Acc]);
next_row([H1, H2|T], Acc) ->
  next_row([H2|T], [H1 + H2 | Acc]).