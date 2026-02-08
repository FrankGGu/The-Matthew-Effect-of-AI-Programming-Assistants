-module(repeated_string_match).
-export([repeated_string_match/2]).

repeated_string_match(A, B) ->
  LenA = length(A),
  LenB = length(B),
  MaxRepeats = (LenB div LenA) + 2,
  RepeatedA = string:copies(A, 1),
  case string:str(RepeatedA, B) of
    0 ->
      RepeatedA2 = string:copies(A, MaxRepeats),
      case string:str(RepeatedA2, B) of
        0 -> -1;
        _ ->
          case LenB > LenA of
            true ->
              Repeats = (LenB + LenA - 1) div LenA;
              RepeatedA3 = string:copies(A, Repeats);
              case string:str(RepeatedA3, B) of
                0 ->
                  Repeats + 1;
                _ ->
                  Repeats
              end;
            false ->
              case string:str(A, B) of
                0 -> 1;
                _ -> -1
              end
          end
      end;
    _ -> 1
  end.