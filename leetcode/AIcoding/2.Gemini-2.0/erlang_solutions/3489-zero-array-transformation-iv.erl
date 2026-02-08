-module(zero_array_transformation_iv).
-export([can_transform/2]).

can_transform(Nums, Operations) ->
  can_transform(Nums, Operations, []).

can_transform([], [], _Acc) ->
  true;
can_transform(Nums, [], _Acc) ->
  lists:all(fun(X) -> X == 0 end, Nums);
can_transform(Nums, Operations, Acc) ->
  case lists:keyfind(0, 1, Nums) of
    false ->
      lists:all(fun(X) -> X == 0 end, Nums);
    {0, Index} ->
      NewNums = lists:sublist(Nums, 1, Index - 1) ++
                lists:sublist(Nums, Index + 1, length(Nums) - Index),
      case Operations of
        [] ->
          lists:all(fun(X) -> X == 0 end, NewNums);
        [Op | RestOps] ->
          case Op of
            {Type, Val} ->
              case Type of
                0 ->
                  NewNewNums = lists:map(fun(X) ->
                                             if X =:= Val ->
                                               0;
                                             true ->
                                               X
                                             end
                                         end, NewNums),
                  can_transform(NewNewNums, RestOps, Acc ++ [Op]);
                1 ->
                  NewNewNums = lists:map(fun(X) ->
                                             if X =/= Val ->
                                               0;
                                             true ->
                                               X
                                             end
                                         end, NewNums),
                  can_transform(NewNewNums, RestOps, Acc ++ [Op])
              end
          end
      end
  end.