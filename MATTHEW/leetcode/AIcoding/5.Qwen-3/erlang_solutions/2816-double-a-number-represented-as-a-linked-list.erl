-module(double_linked_list).
-export([double_it/1]).

-record(list_node, {val, next}).

double_it(#list_node{val = Val, next = Next}) ->
    case Next of
        nil ->
            #list_node{val = Val * 2, next = nil};
        _ ->
            DoubleNext = double_it(Next),
            if
                Val == 0 ->
                    #list_node{val = 0, next = DoubleNext};
                true ->
                    NewVal = Val * 2,
                    if
                        NewVal < 10 ->
                            #list_node{val = NewVal, next = DoubleNext};
                        true ->
                            Carry = NewVal div 10,
                            NewVal2 = NewVal rem 10,
                            #list_node{val = NewVal2, next = double_it(#list_node{val = Carry, next = DoubleNext})}
                    end
            end
    end.