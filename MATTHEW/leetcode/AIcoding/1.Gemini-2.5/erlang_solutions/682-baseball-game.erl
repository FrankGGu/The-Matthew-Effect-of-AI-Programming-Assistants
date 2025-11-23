-module(solution).
-export([calPoints/1]).

calPoints(Ops) ->
    process_ops(Ops, []).

process_ops([], Scores) ->
    lists:sum(Scores);
process_ops([Op | RestOps], Scores) ->
    NewScores =
        case Op of
            "C" ->
                [_ | T] = Scores,
                T;
            "D" ->
                [H | _] = Scores,
                [2 * H | Scores];
            "+" ->
                [H1, H2 | _] = Scores,
                [H1 + H2 | Scores];
            _ -> % Must be an integer string
                IntVal = list_to_integer(Op),
                [IntVal | Scores]
        end,
    process_ops(RestOps, NewScores).