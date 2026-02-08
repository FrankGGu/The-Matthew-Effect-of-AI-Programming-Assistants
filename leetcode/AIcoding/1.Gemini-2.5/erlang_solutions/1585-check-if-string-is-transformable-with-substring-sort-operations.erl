-module(solution).
-export([can_be_transformed/2]).

count_chars(Str) ->
    lists:foldl(fun(Char, Acc) ->
        maps:update_with(Char, fun(Count) -> Count + 1 end, 1, Acc)
    end, #{}, Str).

check_anagrams(S, T) ->
    count_chars(S) == count_chars(T).

build_queues(Str) ->
    lists:foldl(fun(Char, {Idx, Acc}) ->
        NewAcc = maps:update_with(Char, fun(L) -> L ++ [Idx] end, [Idx], Acc),
        {Idx + 1, NewAcc}
    end, {0, #{}}, Str).

can_be_transformed(S, T) ->
    if not check_anagrams(S, T) ->
        false;
    true ->
        {_LastIdx, CharQueues} = build_queues(S),
        check_transformable(T, CharQueues)
    end.

check_transformable(T, InitialCharQueues) ->
    lists:foldl(fun(TargetChar, AccQueues) ->
        case AccQueues of
            false -> false; %% Propagate failure from previous iteration
            _ ->
                CharQueue = maps:get(TargetChar, AccQueues),
                %% This pattern match will fail if CharQueue is empty.
                %% However, since we've already checked that S and T are anagrams,
                %% CharQueue should not be empty if TargetChar is still in T.
                [SOriginalIdx | RestQueue] = CharQueue, 

                UpdatedQueues = maps:put(TargetChar, RestQueue, AccQueues),

                IsBlocked = lists:any(fun(SmallerChar) ->
                    maps:is_key(SmallerChar, UpdatedQueues) andalso
                    (not lists:is_empty(maps:get(SmallerChar, UpdatedQueues))) andalso
                    (hd(maps:get(SmallerChar, UpdatedQueues)) < SOriginalIdx)
                end, lists:seq($0, TargetChar - 1)),

                if IsBlocked -> false;
                true -> UpdatedQueues
                end
        end
    end, InitialCharQueues, T) =/= false.