-module(find_string_lcp).
-export([find_string/1]).

find_string(LCP) ->
  N = length(LCP),
  {ok, Result} = solve(LCP, N, []),
  Result.

solve(LCP, N, Acc) ->
  case is_valid(LCP, N) of
    true ->
      Result = lists:reverse(Acc),
      {ok, list_to_binary(Result)};
    false ->
      {error, ""}
  end.

is_valid(LCP, N) ->
  Valid = fun(I,J) ->
            case LCP[I+1][J+1] of
              0 -> true;
              _ ->
                case I == N-1 orelse J == N-1 of
                  true -> false;
                  false ->
                    case LCP[I+1][J+1] =< min(LCP[I+1], LCP[J+1]) of
                      true -> true;
                      false -> false
                    end
                end
            end
          end,

  check_lcp(LCP,N,Valid).

check_lcp(LCP, N, Valid) ->
  check_lcp_helper(LCP, N, 0, 0, Valid).

check_lcp_helper(_LCP, N, N, _J, _Valid) ->
  true;
check_lcp_helper(_LCP, N, _I, N, _Valid) ->
  true;
check_lcp_helper(LCP, N, I, J, Valid) ->
  case Valid(I,J) of
    true ->
      check_lcp_helper(LCP, N, I, J+1, Valid);
    false ->
      false
  end;
check_lcp_helper(LCP, N, I, J, Valid) when J >= N ->
  check_lcp_helper(LCP, N, I+1, 0, Valid);
check_lcp_helper(LCP, N, I, J, Valid) when I >= N ->
  true.