-module(median_finder).
-export([init/0, add_num/1, find_median/0]).

-record(state, {left = [] :: list(), right = [] :: list()}).

init() ->
    #state{}.

add_num(Num, State = #state{left = Left, right = Right}) ->
    case {Left, Right} of
        {[], []} ->
            State#state{left = [Num]};
        {_, []} ->
            case Num > hd(Left) of
                true -> State#state{right = [Num]};
                false -> State#state{left = [Num], right = Left}
            end;
        {_, _} ->
            case length(Left) =:= length(Right) of
                true ->
                    case Num =< hd(Right) of
                        true -> State#state{left = insert_desc(Num, Left)};
                        false -> State#state{left = [hd(Right)], right = tl(Right) ++ [Num]}
                    end;
                false ->
                    case Num >= hd(Left) of
                        true -> State#state{right = insert_asc(Num, Right)};
                        false -> State#state{right = [hd(Left)], left = tl(Left) ++ [Num]}
                    end
            end
    end.

find_median(#state{left = Left, right = Right}) ->
    case length(Left) =:= length(Right) of
        true -> (hd(Left) + hd(Right)) / 2;
        false -> hd(Left)
    end.

insert_asc(Num, []) -> [Num];
insert_asc(Num, [H | T]) when Num =< H -> [Num, H | T];
insert_asc(Num, [H | T]) -> [H | insert_asc(Num, T)].

insert_desc(Num, []) -> [Num];
insert_desc(Num, [H | T]) when Num >= H -> [Num, H | T];
insert_desc(Num, [H | T]) -> [H | insert_desc(Num, T)].

add_num(Num) ->
    put(median_state, add_num(Num, get(median_state))).

find_median() ->
    find_median(get(median_state)).

init() ->
    put(median_state, #state{}).