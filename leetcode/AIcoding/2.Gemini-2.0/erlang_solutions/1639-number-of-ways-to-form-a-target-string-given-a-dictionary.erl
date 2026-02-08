-module(number_of_ways).
-export([num_ways/2]).

num_ways(Words, Target) ->
    num_ways(Words, Target, []).

num_ways(Words, Target, Memo) ->
    TargetLen = length(Target),
    WordLen = case Words of
                  [] -> 0;
                  [W|_] -> length(hd(Words))
              end,
    num_ways(Words, Target, Memo, TargetLen, WordLen).

num_ways(Words, Target, Memo, TargetLen, WordLen) ->
    case lists:member({Target, TargetLen}, Memo) of
        true ->
            lists:keyfind({Target, TargetLen}, 1, Memo) ! {Target, TargetLen, Ways},
            Ways;
        false ->
            Result = num_ways_helper(Words, Target, TargetLen, WordLen),
            [{Target, TargetLen, Result} | Memo],
            Result
    end.

num_ways_helper(_, [], 0, _) ->
    1;
num_ways_helper(_, [], _, _) ->
    0;
num_ways_helper([], _, _, _) ->
    0;
num_ways_helper(Words, Target, TargetLen, WordLen) ->
    Mod = 1000000007,

    case TargetLen > WordLen of
        true ->
             0;
        false ->
            FirstChar = hd(Target),
            RestTarget = tl(Target),

            Count = lists:foldl(fun(Word, Acc) ->
                                    case lists:nth(1, string:tokens(Word, "")) == [FirstChar] of
                                        true ->
                                            (Acc + num_ways_rest(tl(Words), RestTarget, WordLen)) rem Mod;
                                        false ->
                                            Acc
                                    end
                                end, 0, Words),

            Count
    end.

num_ways_rest([], _, _) ->
    0.

num_ways_rest(Words, Target, WordLen) ->
    Mod = 1000000007,
    case Target of
        [] ->
            1;
        _ ->
            num_ways_helper(Words, Target, length(Target), WordLen)
    end.