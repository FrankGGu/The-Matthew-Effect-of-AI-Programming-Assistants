-module(alternating_groups_ii).
-export([number_of_ways/2]).

number_of_ways(0, _) -> 1;
number_of_ways(N, M) ->
  number_of_ways_helper(N, M, 1, 0) + number_of_ways_helper(N, M, 2, 0).

number_of_ways_helper(0, _, _, _) -> 1;
number_of_ways_helper(N, M, LastGroup, Count) ->
  case N of
    0 -> 1;
    _ ->
      lists:sum([
        case I of
          I when I > 0 and I <= N ->
            case LastGroup of
              1 ->
                case I =/= Count of
                  true -> number_of_ways_helper(N - I, M, 2, I);
                  false -> 0
                end;
              2 ->
                case I =/= Count of
                  true -> number_of_ways_helper(N - I, M, 1, I);
                  false -> 0
                end;
              _ -> 0
            end;
          _ -> 0
        end
       || I <- lists:seq(1, M)
      ])
  end.