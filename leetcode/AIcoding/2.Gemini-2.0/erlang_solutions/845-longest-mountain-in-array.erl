-module(longest_mountain).
-export([longest_mountain/1]).

longest_mountain(A) ->
  N = length(A),
  longest_mountain(A, N, 0, 0, 0, 0).

longest_mountain(_A, N, I, Up, Down, MaxLen) when I >= N ->
  max(MaxLen, Up + Down + 1);

longest_mountain(A, N, I, 0, 0, MaxLen) ->
  case I + 1 < N andalso lists:nth(I + 1, A) > lists:nth(I + 1 - 1, A) of
    true ->
      longest_mountain(A, N, I + 1, 1, 0, MaxLen);
    false ->
      longest_mountain(A, N, I + 1, 0, 0, MaxLen)
  end;

longest_mountain(A, N, I, Up, 0, MaxLen) ->
  case I + 1 < N andalso lists:nth(I + 1, A) > lists:nth(I + 1 - 1, A) of
    true ->
      longest_mountain(A, N, I + 1, Up + 1, 0, MaxLen);
    false ->
      case I + 1 < N andalso lists:nth(I + 1, A) < lists:nth(I + 1 - 1, A) of
        true ->
          longest_mountain(A, N, I + 1, Up, 1, MaxLen);
        false ->
          longest_mountain(A, N, I + 1, 0, 0, max(MaxLen, Up + 1))
      end
  end;

longest_mountain(A, N, I, Up, Down, MaxLen) ->
  case I + 1 < N andalso lists:nth(I + 1, A) < lists:nth(I + 1 - 1, A) of
    true ->
      longest_mountain(A, N, I + 1, Up, Down + 1, MaxLen);
    false ->
      longest_mountain(A, N, I + 1, 0, 0, max(MaxLen, Up + Down + 1))
  end.