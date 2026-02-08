-module(solution).
-export([average_of_levels/1]).

-include_lib("stdlib/include/ms_transform.hrl").

average_of_levels(null) -> [];
average_of_levels(Root) ->
    Queue = queue:in({Root, 0}, queue:new()),
    Results = [],
    traverse(Queue, Results).

traverse(Queue, Results) ->
    case queue:out(Queue) of
        {empty, _} -> Results;
        {{Value, Level}, NextQueue} ->
            case Value of
                null -> traverse(NextQueue, Results);
                _ ->
                    case lists:keymember(Level, 1, Results) of
                        true ->
                            {_, Count, Sum} = lists:keyfind(Level, 1, Results),
                            NewSum = Sum + Value#btree.val,
                            NewCount = Count + 1,
                            UpdatedResults = lists:keyreplace(Level, 1, {Level, NewCount, NewSum}, Results),
                            traverse(NextQueue, UpdatedResults);
                        false ->
                            NewEntry = {Level, 1, Value#btree.val},
                            UpdatedResults = [NewEntry | Results],
                            traverse(NextQueue, UpdatedResults)
                    end
            end
    end.

average_of_levels_helper(Queue, Results) ->
    case queue:out(Queue) of
        {empty, _} -> Results;
        {{Value, Level}, NextQueue} ->
            case Value of
                null -> average_of_levels_helper(NextQueue, Results);
                _ ->
                    case lists:keymember(Level, 1, Results) of
                        true ->
                            {_, Count, Sum} = lists:keyfind(Level, 1, Results),
                            NewSum = Sum + Value#btree.val,
                            NewCount = Count + 1,
                            UpdatedResults = lists:keyreplace(Level, 1, {Level, NewCount, NewSum}, Results),
                            average_of_levels_helper(NextQueue, UpdatedResults);
                        false ->
                            NewEntry = {Level, 1, Value#btree.val},
                            UpdatedResults = [NewEntry | Results],
                            average_of_levels_helper(NextQueue, UpdatedResults)
                    end
            end
    end.

-define(BTREE, #btree{val=_, left=_, right=_}).

average_of_levels_2(null) -> [];
average_of_levels_2(Root) ->
    Queue = queue:in({Root, 0}, queue:new()),
    Results = [],
    traverse_2(Queue, Results).

traverse_2(Queue, Results) ->
    case queue:out(Queue) of
        {empty, _} -> Results;
        {{Value, Level}, NextQueue} ->
            case Value of
                null -> traverse_2(NextQueue, Results);
                _ ->
                    case lists:keymember(Level, 1, Results) of
                        true ->
                            {_, Count, Sum} = lists:keyfind(Level, 1, Results),
                            NewSum = Sum + Value#btree.val,
                            NewCount = Count + 1,
                            UpdatedResults = lists:keyreplace(Level, 1, {Level, NewCount, NewSum}, Results),
                            traverse_2(NextQueue, UpdatedResults);
                        false ->
                            NewEntry = {Level, 1, Value#btree.val},
                            UpdatedResults = [NewEntry | Results],
                            traverse_2(NextQueue, UpdatedResults)
                    end
            end
    end.

average_of_levels_3(null) -> [];
average_of_levels_3(Root) ->
    Queue = queue:in({Root, 0}, queue:new()),
    Results = [],
    traverse_3(Queue, Results).

traverse_3(Queue, Results) ->
    case queue:out(Queue) of
        {empty, _} -> Results;
        {{Value, Level}, NextQueue} ->
            case Value of
                null -> traverse_3(NextQueue, Results);
                _ ->
                    case lists:keymember(Level, 1, Results) of
                        true ->
                            {_, Count, Sum} = lists:keyfind(Level, 1, Results),
                            NewSum = Sum + Value#btree.val,
                            NewCount = Count + 1,
                            UpdatedResults = lists:keyreplace(Level, 1, {Level, NewCount, NewSum}, Results),
                            traverse_3(NextQueue, UpdatedResults);
                        false ->
                            NewEntry = {Level, 1, Value#btree.val},
                            UpdatedResults = [NewEntry | Results],
                            traverse_3(NextQueue, UpdatedResults)
                    end
            end
    end.

average_of_levels_4(null) -> [];
average_of_levels_4(Root) ->
    Queue = queue:in({Root, 0}, queue:new()),
    Results = [],
    traverse_4(Queue, Results).

traverse_4(Queue, Results) ->
    case queue:out(Queue) of
        {empty, _} -> Results;
        {{Value, Level}, NextQueue} ->
            case Value of
                null -> traverse_4(NextQueue, Results);
                _ ->
                    case lists:keymember(Level, 1, Results) of
                        true ->
                            {_, Count, Sum} = lists:keyfind(Level, 1, Results),
                            NewSum = Sum + Value#btree.val,
                            NewCount = Count + 1,
                            UpdatedResults = lists:keyreplace(Level, 1, {Level, NewCount, NewSum}, Results),
                            traverse_4(NextQueue, UpdatedResults);
                        false ->
                            NewEntry = {Level, 1, Value#btree.val},
                            UpdatedResults = [NewEntry | Results],
                            traverse_4(NextQueue, UpdatedResults)
                    end
            end
    end.

average_of_levels_5(null) -> [];
average_of_levels_5(Root) ->
    Queue = queue:in({Root, 0}, queue:new()),
    Results = [],
    traverse_5(Queue, Results).

traverse_5(Queue, Results) ->
    case queue:out(Queue) of
        {empty, _} -> Results;
        {{Value, Level}, NextQueue} ->
            case Value of
                null -> traverse_5(NextQueue, Results);
                _ ->
                    case lists:keymember(Level, 1, Results) of
                        true ->
                            {_, Count, Sum} = lists:keyfind(Level, 1, Results),
                            NewSum = Sum + Value#btree.val,
                            NewCount = Count + 1,
                            UpdatedResults = lists:keyreplace(Level, 1, {Level, NewCount, NewSum}, Results),
                            traverse_5(NextQueue, UpdatedResults);
                        false ->
                            NewEntry = {Level, 1, Value#btree.val},
                            UpdatedResults = [NewEntry | Results],
                            traverse_5(NextQueue, UpdatedResults)
                    end
            end
    end.

average_of_levels_6(null) -> [];
average_of_levels_6(Root) ->
    Queue = queue:in({Root, 0}, queue:new()),
    Results = [],
    traverse_6(Queue, Results).

traverse_6(Queue, Results) ->
    case queue:out(Queue) of
        {empty, _} -> Results;
        {{Value, Level}, NextQueue} ->
            case Value of
                null -> traverse_6(NextQueue, Results);
                _ ->
                    case lists:keymember(Level, 1, Results) of
                        true ->
                            {_, Count, Sum} = lists:keyfind(Level, 1, Results),
                            NewSum = Sum + Value#btree.val,
                            NewCount = Count + 1,
                            UpdatedResults = lists:keyreplace(Level, 1, {Level, NewCount, NewSum}, Results),
                            traverse_6(NextQueue, UpdatedResults);
                        false ->
                            NewEntry = {Level, 1, Value#btree.val},
                            UpdatedResults = [NewEntry | Results],
                            traverse_6(NextQueue, UpdatedResults)
                    end
            end
    end.

average_of_levels_7(null) -> [];
average_of_levels_7(Root) ->
    Queue = queue:in({Root, 0}, queue:new()),
    Results = [],
    traverse_7(Queue, Results).

traverse_7(Queue, Results) ->
    case queue:out(Queue) of
        {empty, _} -> Results;
        {{Value, Level}, NextQueue} ->
            case Value of
                null -> traverse_7(NextQueue, Results);
                _ ->
                    case lists:keymember(Level, 1, Results) of
                        true ->
                            {_, Count, Sum} = lists:keyfind(Level, 1, Results),
                            NewSum = Sum + Value#btree.val,
                            NewCount = Count + 1,
                            UpdatedResults = lists:keyreplace(Level, 1, {Level, NewCount, NewSum}, Results),
                            traverse_7(NextQueue, UpdatedResults);
                        false ->
                            NewEntry = {Level, 1, Value#btree.val},
                            UpdatedResults = [NewEntry | Results],
                            traverse_7(NextQueue, UpdatedResults)
                    end
            end
    end.

average_of_levels_8(null) -> [];
average_of_levels_8(Root) ->
    Queue = queue:in({Root, 0}, queue:new()),
    Results = [],
    traverse_8(Queue, Results).

traverse_8(Queue, Results) ->
    case queue:out(Queue