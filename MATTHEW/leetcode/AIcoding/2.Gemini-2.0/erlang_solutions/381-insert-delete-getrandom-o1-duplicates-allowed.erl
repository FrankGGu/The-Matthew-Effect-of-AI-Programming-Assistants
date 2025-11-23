-module(randomized_collection).
-export([new/0, insert/2, remove/2, getRandom/1]).

new() ->
    {[], []}.

insert({Values, Indices}, Val) ->
    Len = length(Values),
    NewValues = [Val | Values],
    NewIndices = [{Val, Len} | Indices],
    {NewValues, NewIndices}.

remove({Values, Indices}, Val) ->
    case find_index(Indices, Val) of
        none ->
            {Values, Indices};
        Index ->
            Len = length(Values),
            {ValueToRemove, IndexToRemove} = lists:nth(Index, Indices),

            NewValues =
              case IndexToRemove =:= 0 of
                true -> tl(Values);
                false ->
                  lists:sublist(Values, 1, IndexToRemove) ++
                  tl(lists:sublist(Values, IndexToRemove, Len - IndexToRemove + 1))
              end,

            case IndexToRemove =:= Len-1 of
              true ->
                LastValue = lists:nth(0,Values);
                NewIndices = lists:keydelete({Val,IndexToRemove},1,Indices);
              false ->
                LastValue = lists:nth(0,Values);
                {NewValues2,NewIndices2} =
                  case Len =:= 1 of
                    true -> {[],[]};
                    false ->
                      case IndexToRemove =:= 0 of
                        true -> {tl(Values),lists:keydelete({Val,IndexToRemove},1,Indices)};
                        false ->

                          {lists:sublist(Values, 1, IndexToRemove) ++
                           tl(lists:sublist(Values, IndexToRemove, Len - IndexToRemove + 1)),
                           lists:keydelete({Val,IndexToRemove},1,Indices)};
                      end;
                  end,
                {NewValues2,NewIndices2} =
                  case NewIndices2 =:= [] of
                    true -> {NewValues2,[]};
                    false ->
                      case lists:keymember({LastValue,IndexToRemove},1,NewIndices2) of
                        true -> {NewValues2,NewIndices2};
                        false ->
                          case IndexToRemove > 0 of
                            true ->
                              {NewValues2,lists:keyreplace({LastValue,0},1,NewIndices2,[{LastValue,IndexToRemove-1}|lists:keydelete({LastValue,0},1,NewIndices2)])};
                            false -> {NewValues2,NewIndices2}
                          end
                      end
                    end,
                {NewValues2,NewIndices2}
            end
    end.

getRandom({Values, _}) ->
    Len = length(Values),
    case Len > 0 of
        true ->
            Rand = rand:uniform(Len),
            lists:nth(Rand, Values);
        false ->
            undefined
    end.

find_index(Indices, Val) ->
    find_index(Indices, Val, 1).

find_index([], _, _) ->
    none;
find_index([{Val, _} | _], Val, Index) ->
    Index;
find_index([{OtherVal, _} | Rest], Val, Index) when OtherVal /= Val ->
    find_index(Rest, Val, Index + 1);
find_index([_ | Rest], Val, Index) ->
    find_index(Rest, Val, Index + 1).