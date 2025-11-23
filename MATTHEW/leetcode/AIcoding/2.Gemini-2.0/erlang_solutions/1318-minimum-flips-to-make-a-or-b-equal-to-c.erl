-module(minimum_flips).
-export([min_flips/3]).

min_flips(A, B, C) ->
  min_flips_helper(A, B, C, 0).

min_flips_helper(0, 0, 0, Acc) -> Acc;
min_flips_helper(A, B, C, Acc) ->
  BitA = A band 1,
  BitB = B band 1,
  BitC = C band 1,
  A1 = A bsr 1,
  B1 = B bsr 1,
  C1 = C bsr 1,

  case BitC of
    1 ->
      case BitA bor BitB of
        1 -> min_flips_helper(A1, B1, C1, Acc);
        0 -> min_flips_helper(A1, B1, C1, Acc + 1)
      end;
    0 ->
      case BitA bor BitB of
        1 ->
          case {BitA, BitB} of
            {1, 1} -> min_flips_helper(A1, B1, C1, Acc + 2);
            {1, 0} -> min_flips_helper(A1, B1, C1, Acc + 1);
            {0, 1} -> min_flips_helper(A1, B1, C1, Acc + 1);
            _ -> min_flips_helper(A1, B1, C1, Acc) % Impossible case
          end;
        0 -> min_flips_helper(A1, B1, C1, Acc)
      end
  end.