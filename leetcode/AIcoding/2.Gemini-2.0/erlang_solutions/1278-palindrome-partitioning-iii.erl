-module(palindrome_partitioning_iii).
-export([palindromePartitioning/2]).

palindromePartitioning(S, K) ->
  N = length(S),
  P = make_palindrome_matrix(S, N),
  DP = array:new([N + 1, K + 1], {fixed, infinity}),
  array:set({0, 0}, 0, DP),

  for(I = 1, I =< N, I = I + 1,
    for(J = 1, J =< K, J = J + 1,
      for(X = 1, X =< I, X = X + 1,
        Prev = array:get({X - 1, J - 1}, DP),
        if
          Prev < infinity ->
            Cost = array:get({I - X + 1, X}, P),
            NewVal = Prev + Cost,
            Curr = array:get({I, J}, DP),
            if
              NewVal < Curr ->
                array:set({I, J}, NewVal, DP)
              true ->
                ok
            end
          true ->
            ok
        end
      end
    )
  ),

  array:get({N, K}, DP).

make_palindrome_matrix(S, N) ->
  P = array:new([N + 1, N + 1], {fixed, 0}),
  for(I = 1, I =< N, I = I + 1,
    for(J = 1, J =< I, J = J + 1,
      Cost = count_changes(S, J, I),
      array:set({I - J + 1, J}, Cost, P)
    )
  ),
  P.

count_changes(S, Start, End) ->
  Count = 0,
  Len = End - Start + 1,
  Mid = Len div 2,
  for(I = 0, I < Mid, I = I + 1,
    if
      lists:nth(Start + I, S) /= lists:nth(End - I, S) ->
        Count = Count + 1
      true ->
        ok
    end
  ),
  Count.

for(Start, End, Increment, Body) ->
  for(Start, Increment, End, Body, []).

for(Start, Increment, End, Body, Acc) when Start > End ->
  lists:reverse(Acc);
for(Start, Increment, End, Body, Acc) ->
  for(Start + Increment, Increment, End, Body, [Body(Start) | Acc]).