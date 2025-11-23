-module(median_finder).
-export([new/0, add_num/2, find_median/1]).

-record(state, {left = [], right = []}).

new() ->
    #state{}.

add_num(State, Num) ->
    #state{left = Left, right = Right} = State,
    case is_empty(Left) of
        true ->
            NewLeft = [Num | Left],
            State#state{left = NewLeft};
        false ->
            case Num < hd(Left) of
                true ->
                    NewLeft = [Num | Left],
                    State#state{left = NewLeft};
                false ->
                    NewRight = [Num | Right],
                    State#state{right = NewRight}
            end
    end.

find_median(State) ->
    #state{left = Left, right = Right} = State,
    Len = length(Left) + length(Right),
    case Len rem 2 of
        0 ->
            (hd(Left) + hd(Right)) / 2;
        1 ->
            hd(Left)
    end.

is_empty(List) ->
    List == [].