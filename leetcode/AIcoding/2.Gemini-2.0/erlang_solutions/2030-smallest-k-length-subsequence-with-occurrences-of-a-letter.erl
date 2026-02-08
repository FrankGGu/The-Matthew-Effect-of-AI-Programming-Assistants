-module(smallest_k_length_subsequence).
-export([smallest_subsequence/3]).

smallest_subsequence(S, K, Letter) ->
  smallest_subsequence(S, K, Letter, 0).

smallest_subsequence(S, K, Letter, Repetition) ->
  smallest_subsequence(S, K, Letter, Repetition, []).

smallest_subsequence(S, K, Letter, Repetition, Acc) ->
  smallest_subsequence(string:to_list(S), K, Letter, Repetition, Acc, 0).

smallest_subsequence([], _, _, _, Acc, Needed) ->
  case Needed > 0 of
    true ->  [];
    false -> lists:reverse(Acc)
  end;
smallest_subsequence([H | T], K, Letter, Repetition, Acc, Needed) ->
  Len = length(Acc),
  case Len > 0 andalso (H < lists:last(Acc)) andalso ((length([X || X <- [H|T], X == Letter]) + (lists:sum([case X == Letter of true -> 1; false -> 0 end || X <- Acc]))) > Repetition - (lists:sum([case X == Letter of true -> 1; false -> 0 end || X <- Acc]))) andalso (Len + length([H|T]) > K) of
    true ->
      smallest_subsequence([H|T], K, Letter, Repetition, lists:droplast(Acc), Needed);
    false ->
      case Len < K of
        true ->
          case H == Letter of
            true ->
              smallest_subsequence(T, K, Letter, Repetition, [H | Acc], Needed - 1);
            false ->
              case Needed > 0 or (K - Len > length([X || X <- T, X == Letter])) of
                true ->
                  smallest_subsequence(T, K, Letter, Repetition, Acc, Needed);
                false ->
                  smallest_subsequence(T, K, Letter, Repetition, [H | Acc], Needed)
              end;
          end;
        false ->
          case Needed > 0 of
            true ->
              smallest_subsequence(T, K, Letter, Repetition, Acc, Needed);
            false ->
              lists:reverse(Acc)
          end
      end
  end.