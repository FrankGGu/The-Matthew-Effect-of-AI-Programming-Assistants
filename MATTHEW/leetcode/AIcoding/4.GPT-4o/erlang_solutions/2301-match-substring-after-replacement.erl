-module(solution).
-export([evaluate/2]).

evaluate(S, T) ->
    evaluate(S, T, 0, 0).

evaluate([], _, _, _) ->
    true;
evaluate(_, [], _, _) ->
    false;
evaluate([SChar | SRest], [TChar | TRest], SIndex, TIndex) ->
    case SChar of
        $* ->
            evaluate(SRest, TRest, SIndex + 1, TIndex);
        _ ->
            case TChar of
                $* ->
                    evaluate(SRest, TRest, SIndex, TIndex + 1);
                _ when SChar =:= TChar ->
                    evaluate(SRest, TRest, SIndex + 1, TIndex + 1);
                _ ->
                    false
            end
    end.