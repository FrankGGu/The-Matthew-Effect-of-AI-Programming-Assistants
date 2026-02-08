-module(minimum_buckets).
-export([minimum_buckets/1]).

minimum_buckets(hamsters) ->
  minimum_buckets(hamsters, 0, 0).

minimum_buckets([], Acc, Prev) ->
  Acc;
minimum_buckets([H|T], Acc, Prev) ->
  case H of
    'H' ->
      case Prev of
        0 ->
          case T of
            [] ->
              Acc;
            [_] ->
              minimum_buckets(T, Acc + 1, 1);
            [_|_] ->
              case lists:nth(1, T) of
                'H' ->
                  Acc -1;
                '.' ->
                  minimum_buckets(T, Acc + 1, 1);
                _ ->
                  Acc -1
              end
          end;
        1 ->
          minimum_buckets(T, Acc - 1, 0);
        _ ->
          minimum_buckets(T, Acc - 1, 0)
      end;
    '.' ->
      minimum_buckets(T, Acc, 0)
  end.

minimum_buckets(Hamsters, Acc, Prev) ->
  Len = length(Hamsters),
  case Len of
    0 -> Acc;
    _ ->
      Filtered = lists:filter(fun(X) -> X == 'H' end, Hamsters),
      case length(Filtered) of
        0 ->
          0;
        _ ->
          minimum_buckets_helper(Hamsters, 0)
      end
  end.

minimum_buckets_helper(Hamsters, Acc) ->
  case Hamsters of
    [] ->
      Acc;
    ['H'] ->
      case Acc > 0 of
        true -> Acc;
        false -> -1
      end;
    ['H'|T] ->
      case T of
        [] ->
          case Acc > 0 of
            true -> Acc;
            false -> -1
          end;
        ['.'|TT] ->
          minimum_buckets_helper(TT, Acc + 1);
        ['H'|_] ->
          -1;
        _ -> -1
      end;
    ['.'|T] ->
      minimum_buckets_helper(T, Acc);
    _ -> -1
  end.