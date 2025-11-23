-module(min_insertions).
-export([min_insertions/1]).

min_insertions(S) ->
  N = length(S),
  DP = array:new([N+1,N+1], {fixed,0}),
  min_insertions_helper(S, 1, N, DP).

min_insertions_helper(S, I, J, DP) ->
  case array:is_defined(DP, [I,J]) of
    true ->
      array:get([I,J], DP);
    false ->
      case I > J of
        true ->
          0;
        false ->
          case I == J of
            true ->
              0;
            false ->
              case lists:nth(I, S) == lists:nth(J, S) of
                true ->
                  Result = min_insertions_helper(S, I+1, J-1, DP),
                  array:set([I,J], Result, DP),
                  Result;
                false ->
                  Result1 = min_insertions_helper(S, I+1, J, DP) + 1,
                  Result2 = min_insertions_helper(S, I, J-1, DP) + 1,
                  Result = min(Result1, Result2),
                  array:set([I,J], Result, DP),
                  Result
              end
          end
      end
  end.