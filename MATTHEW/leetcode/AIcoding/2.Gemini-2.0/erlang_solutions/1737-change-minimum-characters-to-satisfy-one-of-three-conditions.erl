-module(change_minimum_characters).
-export([min_characters/1]).

min_characters(A) ->
  N = length(A),
  min_val(N, A).

min_val(N, A) ->
  min(
    min_same(N, A),
    min(
      min_a_lt_b(N, A),
      min_b_lt_a(N, A)
    )
  ).

min_same(N, A) ->
  lists:foldl(
    fun(C, Acc) ->
      Acc1 = lists:foldl(
        fun(X, Acc2) ->
          if
            X == C -> Acc2
          ;
            true -> Acc2 + 1
          end
        , 0, A
      ),
      min(Acc, Acc1)
    end,
    N,
    lists:seq($a, $z)
  ).

min_a_lt_b(N, A) ->
  lists:foldl(
    fun(C, Acc) ->
      A_count = lists:foldl(
        fun(X, Acc2) ->
          if
            X < C -> Acc2
          ;
            true -> Acc2 + 1
          end
        , 0, A
      ),
      B_count = lists:foldl(
        fun(X, Acc2) ->
          if
            X >= C -> Acc2
          ;
            true -> Acc2 + 1
          end
        , 0, A
      ),
      min(Acc, A_count + B_count)
    end,
    N,
    lists:seq($b, $z)
  ).

min_b_lt_a(N, A) ->
  lists:foldl(
    fun(C, Acc) ->
      A_count = lists:foldl(
        fun(X, Acc2) ->
          if
            X > C -> Acc2
          ;
            true -> Acc2 + 1
          end
        , 0, A
      ),
      B_count = lists:foldl(
        fun(X, Acc2) ->
          if
            X <= C -> Acc2
          ;
            true -> Acc2 + 1
          end
        , 0, A
      ),
      min(Acc, A_count + B_count)
    end,
    N,
    lists:seq($a, $y)
  ).