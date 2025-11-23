-module(range_module).
-export([init/0, addRange/3, queryRange/3, removeRange/3]).

-record(interval, {start, end}).

init() ->
    [].

addRange(Intervals, Left, Right) ->
    merge(insert(Intervals, #interval{start=Left, end=Right})).

queryRange(Intervals, Left, Right) ->
    case find_interval(Intervals, Left) of
        {ok, #interval{start=S, end=E}} when S =< Left, Right =< E ->
            true;
        _ ->
            false
    end.

removeRange(Intervals, Left, Right) ->
    remove(Intervals, Left, Right).

insert([], New) ->
    [New];
insert([I=#interval{start=S, end=E}|Rest], New=#interval{start=NS, end=NE}) ->
    if
        NE < S ->
            [New, I|Rest];
        E < NS ->
            [I|insert(Rest, New)];
        true ->
            [#interval{start=min(S, NS), end=max(E, NE)}|Rest]
    end.

merge(Intervals) ->
    lists:foldl(fun(I, Acc) -> insert(Acc, I) end, [], Intervals).

find_interval([], _) ->
    not_found;
find_interval([I=#interval{start=S, end=E}|Rest], Val) ->
    if
        Val < S ->
            not_found;
        Val =< E ->
            {ok, I};
        true ->
            find_interval(Rest, Val)
    end.

remove(Intervals, Left, Right) ->
    lists:foldl(fun(I=#interval{start=S, end=E}, Acc) ->
        if
            E =< Left; S >= Right ->
                [I|Acc];
            S < Left, Right < E ->
                [#interval{start=S, end=Left}, #interval{start=Right, end=E}|Acc];
            S < Left ->
                [#interval{start=S, end=Left}|Acc];
            Right < E ->
                [#interval{start=Right, end=E}|Acc];
            true ->
                Acc
        end
    end, [], Intervals).

min(A, B) when A < B -> A;
min(_, B) -> B.

max(A, B) when A > B -> A;
max(_, B) -> B.