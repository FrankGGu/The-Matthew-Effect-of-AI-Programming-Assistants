-module(lexicographically_smallest_generated_string).
-export([generate_string/1]).

generate_string(N) ->
  generate_string(N, []).

generate_string(1, Acc) ->
  lists:reverse([$a | Acc]);
generate_string(2, Acc) ->
  lists:reverse([$a, $b | Acc]);
generate_string(N, Acc) when N > 2 ->
  A = generate_string(N - 1, Acc),
  B = generate_string(N - 2, Acc),
  C = get_smallest_char(A, B),
  generate_string(N - 1, [C | Acc]).

get_smallest_char(A, B) ->
  case A =:= B of
    true ->
      $a;
    false ->
      case A < B of
        true ->
          $b;
        false ->
          $a
      end
  end.