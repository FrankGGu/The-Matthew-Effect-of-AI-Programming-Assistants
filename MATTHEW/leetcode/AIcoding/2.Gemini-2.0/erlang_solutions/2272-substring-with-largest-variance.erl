-module(largest_variance).
-export([largest_variance/1]).

largest_variance(S) ->
  largest_variance_helper(S, lists:usort(string:tokens(S, ""))).

largest_variance_helper(S, Chars) ->
  MaxVariance = lists:foldl(
    fun(C1, Acc1) ->
      lists:foldl(
        fun(C2, Acc2) ->
          if C1 == C2 ->
            Acc2
          else
            Variance = calculate_variance(S, C1, C2),
            max(Acc2, Variance)
          end
        , Acc1, Chars)
    end
  , 0, Chars).

calculate_variance(S, Major, Minor) ->
  {MaxSoFar, MinSoFar, MaxEndingHere, MinEndingHere} = lists:foldl(
    fun(Char, {MaxSoFarAcc, MinSoFarAcc, MaxEndingHereAcc, MinEndingHereAcc}) ->
      case Char of
        Major ->
          NewMaxEndingHere = MaxEndingHereAcc + 1,
          NewMinEndingHere = MinEndingHereAcc + 1,
          {max(MaxSoFarAcc, NewMaxEndingHere - MinSoFarAcc), MinSoFarAcc, NewMaxEndingHere, NewMinEndingHere};
        Minor ->
          NewMaxEndingHere = max(MaxEndingHereAcc - 1, 0),
          NewMinEndingHere = MinEndingHereAcc - 1,
          {MaxSoFarAcc, min(MinSoFarAcc, NewMinEndingHere), NewMaxEndingHere, NewMinEndingHere};
        _ ->
          {MaxSoFarAcc, MinSoFarAcc, MaxEndingHereAcc, MinEndingHereAcc}
      end
    end
  , {0, 0, 0, 0}, string:to_list(S)),
  {MaxSoFar, _, _, _} = {MaxSoFar, MinSoFar, MaxEndingHere, MinEndingHere},
  MaxSoFar.