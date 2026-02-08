-module(unique_paths).
-export([unique_paths/2]).

unique_spec(M, N) ->
  [{'m', integer()}, {'n', integer()}].

unique_paths(M, N) ->
  grid(M, N).

grid(M, N) ->
  grid(M, N, []).

grid(M, N, Memo) ->
  case proplists:get_value({M, N}, Memo) of
    undefined ->
      case {M, N} of
        {1, _} -> 1;
        {_, 1} -> 1;
        _ ->
          Paths1 = grid(M - 1, N, Memo),
          Paths2 = grid(M, N - 1, Memo),
          Result = Paths1 + Paths2,
          proplists:put({M, N}, Result, Memo)
      end;
    Value ->
      Value
  end.