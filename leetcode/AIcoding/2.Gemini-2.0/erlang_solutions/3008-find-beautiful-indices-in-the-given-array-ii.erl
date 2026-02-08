-module(find_beautiful_indices_ii).
-export([find_beautiful_indices/3]).

find_beautiful_indices(S, A, B) ->
  find_beautiful_indices(S, A, B, []).

find_beautiful_indices(S, A, B, Acc) ->
  LenS = length(S),
  LenA = length(A),
  LenB = length(B),
  find_beautiful_indices_helper(S, A, B, 0, LenS, LenA, LenB, Acc).

find_beautiful_indices_helper(S, A, B, I, LenS, LenA, LenB, Acc) ->
  if
    I >= LenS ->
      lists:reverse(Acc);
    true ->
      FoundA = string:find(S, A, [{start, I}]),
      case FoundA of
        nomatch ->
          find_beautiful_indices_helper(S, A, B, I + 1, LenS, LenA, LenB, Acc);
        {_, _} ->
          IsBeautiful = is_beautiful(S, A, B, I, LenS, LenA, LenB),
          if
            IsBeautiful ->
              find_beautiful_indices_helper(S, A, B, I + 1, LenS, LenA, LenB, [I | Acc]);
            true ->
              find_beautiful_indices_helper(S, A, B, I + 1, LenS, LenA, LenB, Acc)
          end
      end
  end.

is_beautiful(S, A, B, I, LenS, LenA, LenB) ->
  lists:any(fun(J) ->
    FoundB = string:find(S, B, [{start, J}]),
    case FoundB of
      nomatch ->
        false;
      {_, _} ->
        abs(I - J) =< abs(length(A) - 1 - length(B) + 1)
    end
  end, lists:seq(0, LenS - 1)).