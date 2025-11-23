-module(minimum_skips).
-export([min_skips/2]).

min_skips(Dist, Speed, HoursBefore) ->
    N = length(Dist),
    dp(Dist, Speed, HoursBefore, N).

dp(Dist, Speed, HoursBefore, N) ->
    memo(Dist, Speed, HoursBefore, N, 0).

memo(Dist, Speed, HoursBefore, N, K) ->
    F = fun(DistInner, SpeedInner, HoursBeforeInner, NInner, Memo, KInner) ->
        case Memo of
            _ when NInner < 0 ->
                float_to_integer(HoursBeforeInner * 1.0e9) >= 0;
            _ when KInner > NInner ->
                false;
            _ ->
                D = lists:nth(NInner + 1, DistInner),
                TimeNeeded = D / SpeedInner,
                Skip = memo(DistInner, SpeedInner, HoursBeforeInner - TimeNeeded, NInner - 1, Memo, KInner),
                NoSkip = memo(DistInner, SpeedInner, HoursBeforeInner - math:ceil(TimeNeeded), NInner - 1, Memo, KInner + 1),
                Skip or NoSkip
        end
    end,
    Result = lists:seq(0, N),
    find_min_skips(Dist, Speed, HoursBefore, N, F, Result).

find_min_skips(Dist, Speed, HoursBefore, N, F, [H|T]) ->
    case F(Dist, Speed, HoursBefore, N - 1, [], H) of
        true -> H;
        false -> find_min_skips(Dist, Speed, HoursBefore, N, F, T)
    end;
find_min_skips(_,_,_,_,_,[]) -> -1.