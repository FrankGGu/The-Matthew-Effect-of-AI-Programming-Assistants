-module(valid_clock_times).
-export([count_valid_clock_times/1]).

count_valid_clock_times(Time) ->
  [H1, H2, M1, M2] = string_to_list(Time),
  count(H1, H2, M1, M2).

count(H1, H2, M1, M2) ->
  case {H1, H2, M1, M2} of
    [?, ?, ?, ?] -> 24 * 60;
    [?, ?, ?, C] -> 24 * 6;
    [?, ?, B, ?] -> 24 * 10;
    [?, ?, B, C] -> 24;
    [?, A, ?, ?] ->
      case A of
        '0' -> 10 * 6;
        '1' -> 10 * 6;
        '2' -> 4 * 6;
        _ -> 0
      end;
    [?, A, ?, C] ->
      case A of
        '0' -> 10;
        '1' -> 10;
        '2' -> 4;
        _ -> 0
      end;
    [?, A, B, ?] ->
      case B of
        '0' ->
          case A of
            '0' -> 10;
            '1' -> 10;
            '2' -> 10;
            _ -> 0
          end;
        '1' ->
          case A of
            '0' -> 10;
            '1' -> 10;
            '2' -> 10;
            _ -> 0
          end;
        '2' ->
          case A of
            '0' -> 10;
            '1' -> 10;
            '2' -> 10;
            _ -> 0
          end;
        '3' ->
          case A of
            '0' -> 10;
            '1' -> 10;
            '2' -> 10;
            _ -> 0
          end;
        '4' ->
          case A of
            '0' -> 10;
            '1' -> 10;
            '2' -> 10;
            _ -> 0
          end;
        '5' ->
          case A of
            '0' -> 10;
            '1' -> 10;
            '2' -> 10;
            _ -> 0
          end;
        _ -> 0
      end;
    [?, A, B, C] ->
      case A of
        '0' -> 1;
        '1' -> 1;
        '2' ->
          if B =< '3', C =< '9' -> 1;
             true -> 0
          end;
        _ -> 0
      end;
    [A, ?, ?, ?] ->
      case A of
        '0' -> 10 * 6;
        '1' -> 10 * 6;
        '2' -> 4 * 6;
        _ -> 0
      end;
    [A, ?, ?, C] ->
      case A of
        '0' -> 10;
        '1' -> 10;
        '2' -> 4;
        _ -> 0
      end;
    [A, ?, B, ?] -> 6;
    [A, ?, B, C] ->
      if (A == '2' andalso B >= '4') -> 0;
         true -> 1
      end;
    [A, B, ?, ?] ->
      if (A == '2' andalso B >= '4') -> 0;
         A > '2' -> 0;
         true -> 6 * 10
      end;
    [A, B, ?, C] ->
      if (A == '2' andalso B >= '4') -> 0;
         A > '2' -> 0;
         true -> 10
      end;
    [A, B, C, ?] ->
      if (C > '5') -> 0;
         true -> 10
      end;
    [A, B, C, D] ->
      H = list_to_integer([A - 48, B - 48]),
      M = list_to_integer([C - 48, D - 48]),
      if H < 24 andalso M < 60 -> 1;
         true -> 0
      end
  end.