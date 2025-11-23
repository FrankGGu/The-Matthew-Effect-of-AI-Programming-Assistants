-module(throne_inheritance).
-export([new/1, birth/3, death/2, get_inheritance_order/1]).

new(KingName) ->
    #{ king => KingName,
       people => #{ KingName => #{ children => [], is_dead => false } }
     }.

birth(ParentName, ChildName, #{king := King, people := People} = State) ->
    UpdatedPeople1 = maps:update_with(ParentName,
                                      fun(ParentInfo) ->
                                              % Add child to the head of the list for O(1)
                                              maps:update(children, fun(Children) -> [ChildName | Children] end, ParentInfo)
                                      end,
                                      People),
    UpdatedPeople2 = maps:put(ChildName, #{children => [], is_dead => false}, UpdatedPeople1),
    State#{people := UpdatedPeople2}.

death(Name, #{king := King, people := People} = State) ->
    UpdatedPeople = maps:update_with(Name,
                                     fun(PersonInfo) ->
                                             maps:put(is_dead, true, PersonInfo)
                                     end,
                                     People),
    State#{people := UpdatedPeople}.

get_inheritance_order(#{king := KingName, people := People} = _State) ->
    % The recursive function builds the list in reverse order, so reverse it at the end.
    lists:reverse(get_inheritance_order_recursive(KingName, People, [])).

get_inheritance_order_recursive(Name, People, Acc) ->
    PersonInfo = maps:get(Name, People),

    % If the current person is not dead, add them to the accumulator.
    NewAcc = if maps:get(is_dead, PersonInfo) -> Acc;
               true -> [Name | Acc]
             end,

    Children = maps:get(children, PersonInfo),

    % Children were added to the head of the list, meaning they are in reverse birth order.
    % Reverse them here to process them in correct birth order for pre-order traversal.
    lists:foldl(fun(ChildName, CurrentAcc) ->
                        get_inheritance_order_recursive(ChildName, People, CurrentAcc)
                end, NewAcc, lists:reverse(Children)).