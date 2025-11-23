-module(solution).
-export([modify_string_columns/2]).

modify_string_columns(Table, Columns) ->
  lists:map(
    fun(Row) ->
      lists:map(
        fun(Col) ->
          case lists:member(Col, Columns) of
            true ->
              case lists:nth(Col - 1, Row) of
                null -> null;
                Str -> erlang:list_to_atom(Str)
              end;
            false ->
              lists:nth(Col - 1, Row)
          end
        end,
        lists:seq(1, length(lists:nth(1, Table))))
    end,
    Table
  ).