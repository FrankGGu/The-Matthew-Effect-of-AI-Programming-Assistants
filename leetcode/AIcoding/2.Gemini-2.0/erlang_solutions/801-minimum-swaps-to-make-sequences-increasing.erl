-module(minimum_swaps_to_make_sequences_increasing).
-export([min_swap/2]).

min_swap(A, B) ->
  N = length(A),
  {NoSwap, Swap} = solve(A, B, N, 0, 0, 1),
  min(NoSwap, Swap).

solve(A, B, N, I, NoSwap, Swap) ->
  if I == N - 1 ->
    {NoSwap, Swap}
  else
    if A[I] >= B[I+1] orelse B[I] >= A[I+1] ->
      case {A[I] < A[I+1], B[I] < B[I+1]} of
        {true, true} ->
          {NoSwap + 1, Swap + 1};
        _ ->
          {infinity, infinity}
      end;
    A[I] >= A[I+1] orelse B[I] >= B[I+1] ->
        {infinity, infinity};
    true ->
      {Ns, S} = solve_helper(A, B, N, I, NoSwap, Swap),
      solve(A, B, N, I + 1, Ns, S)
  end.

solve_helper(A, B, N, I, NoSwap, Swap) ->
  if I == N - 1 ->
    {NoSwap, Swap}
  else
    case {A[I] < A[I+1], B[I] < B[I+1]} of
      {true, true} ->
        {min(solve_next(A, B, N, I, NoSwap, 0),solve_next_swap(A, B, N, I, Swap, 1)), min(solve_next_swap(A, B, N, I, NoSwap, 1), solve_next(A, B, N, I, Swap, 0))};
      _ ->
          {infinity,infinity}
    end.

solve_next(A, B, N, I, Prev, Swapped) ->
  if I >= N - 1 ->
    Prev
  else if A[I] < A[I+1] andalso B[I] < B[I+1]->
    solve_next_helper(A,B,N,I,Prev,Swapped);
  true->
    infinity
  end.

solve_next_helper(A,B,N,I,Prev,Swapped) ->
  if I >= N - 1 ->
    Prev
  else if A[I] < A[I+1] andalso B[I] < B[I+1] ->
    solve(A,B,N,I+1,Prev,Swapped);
  true ->
    infinity
  end.

solve_next_swap(A, B, N, I, Prev, Swapped) ->
  if I >= N - 1 ->
    Prev + 1
  else if A[I] < B[I+1] andalso B[I] < A[I+1]->
    solve_next_swap_helper(A,B,N,I,Prev,Swapped);
  true ->
    infinity
  end.

solve_next_swap_helper(A,B,N,I,Prev,Swapped) ->
  if I >= N - 1 ->
    Prev + 1
  else
      SwapA = A[I+1],
      SwapB = B[I+1],
      A1 = lists:nth(I+1,A),
      B1 = lists:nth(I+1,B),
      A_new = lists:replace(I+2,lists:nth(I+1,B),A),
      B_new = lists:replace(I+2,lists:nth(I+1,A),B),
    if A[I] < B[I+1] andalso B[I] < A[I+1] ->
      solve(A, B, N, I+1, Prev+1, Swapped + 1);
    true ->
      infinity
  end.