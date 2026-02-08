-module(longest_happy_prefix).
-export([longest_happy_prefix/1]).

longest_happy_prefix(S) ->
    N = erlang:length(S),
    KMP_table = build_kmp_table(S),
    lists:last(KMP_table).

build_kmp_table(S) ->
    N = erlang:length(S),
    Table = lists:duplicate(N, 0),
    Len = 0,
    I = 1,
    build_kmp_table(S, Table, Len, I).

build_kmp_table(_, Table, _, N) when N >= erlang:length(Table) ->
    Table;
build_kmp_table(S, Table, Len, I) ->
    case erlang:element(I+1, S) == erlang:element(Len+1, S) of
        true ->
            NewLen = Len + 1,
            NewTable = lists:sublist(Table, I) ++ [NewLen] ++ lists:nthtail(I+1, Table),
            build_kmp_table(S, NewTable, NewLen, I+1);
        false ->
            if
                Len > 0 ->
                    build_kmp_table(S, Table, lists:nth(Len, Table), I);
                true ->
                    NewTable = lists:sublist(Table, I) ++ [0] ++ lists:nthtail(I+1, Table),
                    build_kmp_table(S, NewTable, 0, I+1)
            end
    end.