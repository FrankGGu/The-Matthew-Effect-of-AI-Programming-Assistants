-module(solution).
-export([chalk_replacement/2]).

chalk_replacement(needed_chalk, chalk) ->
    TotalChalk = lists:sum(chalk),
    RemainingChalk = needed_chalk rem TotalChalk,
    find_student(RemainingChalk, chalk, 0).

find_student(RemainingChalk, [H | T], Index) ->
    case RemainingChalk >= H of
        true -> find_student(RemainingChalk - H, T, Index + 1);
        false -> Index
    end;
find_student(_, [], Index) -> Index.