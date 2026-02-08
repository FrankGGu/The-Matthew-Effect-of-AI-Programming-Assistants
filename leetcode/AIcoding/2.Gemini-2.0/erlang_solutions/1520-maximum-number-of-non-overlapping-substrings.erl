-module(maximum_non_overlapping_substrings).
-export([max_num_of_substrings/1]).

max_num_of_substrings(S) ->
  N = length(S),
  {First, Last} = find_first_last(S),
  Intervals = build_intervals(S, First, Last),

  lists:reverse(
    lists:foldl(
      fun({L, R}, Acc) ->
        case Acc of
          [] ->
            [{L, R}];
          [{LastL, LastR} | _] ->
            if L > LastR then
              [{L, R} | Acc]
            else
              Acc
            end
        end
      end,
      [],
      lists:sort(
        fun({L1, R1}, {L2, R2}) ->
          R1 < R2 orelse (R1 == R2 andalso L1 < L2)
        end,
        Intervals
      )
    )
  ).

find_first_last(S) ->
  N = length(S),
  First = array:new([$a, $z] ++ [N]),
  Last = array:new([$a, $z] ++ [0]),

  lists:foldl(
    fun({Char, Index}, Acc) ->
      CharIndex = Char - $a + 1,
      array:set(CharIndex, min(Index, array:get(CharIndex, Acc#first))), Acc#first,
      array:set(CharIndex, max(Index, array:get(CharIndex, Acc#last))), Acc#last,
      Acc
    end,
    #{first => First, last => Last},
    lists:zip(string:to_list(S), lists:seq(1, N))
  ),
  {First, Last}.

build_intervals(S, First, Last) ->
  N = length(S),
  lists:foldl(
    fun(Index, Acc) ->
      Char = lists:nth(Index, string:to_list(S)),
      CharIndex = Char - $a + 1,
      L = array:get(CharIndex, First),
      R = array:get(CharIndex, Last),

      case is_valid_interval(S, L, R, First, Last) of
        true ->
          [{L, R} | Acc];
        false ->
          Acc
      end
    end,
    [],
    lists:seq(1, N)
  ).

is_valid_interval(S, L, R, First, Last) ->
  lists:all(
    fun(Index) ->
      Char = lists:nth(Index, string:to_list(S)),
      CharIndex = Char - $a + 1,
      FirstIndex = array:get(CharIndex, First),
      LastIndex = array:get(CharIndex, Last),

      (FirstIndex >= L andalso LastIndex <= R) orelse (FirstIndex > R orelse LastIndex < L)
    end,
    lists:seq(L, R)
  ).