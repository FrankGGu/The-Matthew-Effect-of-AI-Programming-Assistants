-module(reshape_data).
-export([pivot/1]).

pivot(Data) ->
  UniqueNames = lists:usort([D#{}."name" || D <- Data]),
  UniquePivots = lists:usort([D#{}."pivot" || D <- Data]),

  NewData = [
    #{"name" => Name} ++
    lists:foldl(
      fun(Pivot, Acc) ->
        Value = lists:keyfind(Name, 1,
          [#{"name" => D#{}."name", "pivot" => D#{}."pivot", "value" => D#{}."value"} || D <- Data, D#{}."pivot" == Pivot])
        ,
        case Value of
          false ->
            Acc ++ [{Pivot, null}];
          #{"name" => _, "pivot" => _, "value" => V} ->
            Acc ++ [{Pivot, V}]
        end
      end,
      [],
      UniquePivots
    )
    || Name <- UniqueNames
  ],

  lists:map(
    fun(Row) ->
      maps:from_list(
        lists:map(
          fun({Key, Value}) ->
            {list_to_atom(Key), Value}
          end,
          [{"name", maps:get("name", Row)}] ++
          [case {P,V} of
             {P, null} -> {list_to_atom(P), null};
             {P, V} -> {list_to_atom(P), V}
           end || {P,V} <- lists:droplast(maps:to_list(Row),1)]
        )
      )
    end,
    NewData
  ).