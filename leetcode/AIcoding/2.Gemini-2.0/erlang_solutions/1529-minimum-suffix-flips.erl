-module(minimum_suffix_flips).
-export([minFlips/1]).

minFlips(Target) ->
  minFlips(Target, 0, 48).

minFlips([], Acc, _) ->
  Acc;
minFlips([H|T], Acc, Last) ->
  case H of
    $0 ->
      case Last of
        $1 ->
          minFlips(T, Acc + 1, H);
        _ ->
          minFlips(T, Acc, H)
      end;
    $1 ->
      case Last of
        $0 ->
          minFlips(T, Acc + 1, H);
        _ ->
          minFlips(T, Acc, H)
      end
  end.