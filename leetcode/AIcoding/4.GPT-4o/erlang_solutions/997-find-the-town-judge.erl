-module(solution).
-export([find_judge/2]).

find_judge(N, Trust) ->
    TrustCount = lists:foldl(fun({X, Y}, Acc) ->
        Acc#trust{trusted = maps:update_with(Y, fun(_) -> 1; (_) -> 1 end, 0, Acc#trust.trusted),
                   trusted_by = maps:update_with(X, fun(_) -> 1; (_) -> 1 end, 0, Acc#trust.trusted_by)}
    end, #trust{trusted = #{}, trusted_by = #{}}, Trust),
    JudgeCandidates = maps:filter(fun(_, V) -> V == N - 1 end, TrustCount#trust.trusted_by),
    case maps:size(JudgeCandidates) of
        1 -> maps:keys(JudgeCandidates) |> hd;
        _ -> -1
    end.

-record(trust, {trusted = #{}, trusted_by = #{}}).