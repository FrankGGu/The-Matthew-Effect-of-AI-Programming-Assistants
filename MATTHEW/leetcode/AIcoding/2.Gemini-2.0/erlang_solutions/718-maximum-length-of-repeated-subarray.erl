-module(findLength).
-export([findLength/2]).

findLength(A, B) ->
    findLength(A, B, length(A), length(B)).

findLength(A, B, M, N) ->
    DP = array:new([M+1, N+1], 0),
    findLength(A, B, M, N, DP, 0).

findLength(A, B, M, N, DP, MaxLength) ->
    case M of
        0 -> MaxLength;
        _ ->
            case N of
                0 -> MaxLength;
                _ ->
                    AVal = lists:nth(M, A),
                    BVal = lists:nth(N, B),
                    case AVal == BVal of
                        true ->
                            Prev = array:get({M-1, N-1}, DP),
                            NewVal = Prev + 1,
                            array:set({M, N}, NewVal, DP),
                            NewMaxLength = max(MaxLength, NewVal),
                            findLength(A, B, M-1, N-1, DP, NewMaxLength);
                        false ->
                            array:set({M, N}, 0, DP),
                            findLength(A, B, M-1, N-1, DP, MaxLength)
                    end
            end
    end.

max(A, B) ->
    if A > B -> A; true -> B end.

findLength(A, B, M, N, DP, MaxLength) ->
    findLength_helper(A, B, 1, 1, M, N, DP, MaxLength).

findLength_helper(_, _, M1, N1, M, N, _, MaxLength) when M1 > M, N1 > N ->
  MaxLength;

findLength_helper(_, _, M1, N1, M, _, _, MaxLength) when M1 > M ->
  MaxLength;

findLength_helper(_, _, M1, N1, _, N, _, MaxLength) when N1 > N ->
  MaxLength;

findLength_helper(A, B, M1, N1, M, N, DP, MaxLength) ->
  AVal = lists:nth(M1, A),
  BVal = lists:nth(N1, B),
  case AVal == BVal of
    true ->
      Prev = array:get({M1-1, N1-1}, DP),
      NewVal = Prev + 1,
      array:set({M1, N1}, NewVal, DP),
      NewMaxLength = max(MaxLength, NewVal),
      findLength_helper(A, B, M1+1, N1+1, M, N, DP, NewMaxLength);
    false ->
      array:set({M1, N1}, 0, DP),
      findLength_helper(A, B, M1+1, N1+1, M, N, DP, MaxLength)
  end.