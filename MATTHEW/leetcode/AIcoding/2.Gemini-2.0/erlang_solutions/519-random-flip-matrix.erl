-module(random_flip_matrix).
-export([new/2, flip/1, reset/1]).

-record(state, {m, n, total, seen = #{}, rand}).

new(M, N) ->
    #state{m = M, n = N, total = M * N, rand = rand:seed(now())}.

flip(State = #state{m = M, n = N, total = Total, seen = Seen, rand = Rand}) ->
    {Rand1, R} = rand:uniform(Total, Rand),
    {New_R, New_Seen} =
        case maps:is_key(R, Seen) of
            true ->
                New_R1 = maps:get(R, Seen),
                {New_R1, Seen};
            false ->
                {R, Seen}
        end,
    New_Total = Total - 1,
    {Last, New_Seen1} =
        case maps:is_key(New_Total, Seen) of
            true ->
                Last1 = maps:get(New_Total, Seen),
                {Last1, New_Seen};
            false ->
                {New_Total, New_Seen}
        end,

    New_Seen2 =
        case R == New_Total of
            true ->
                New_Seen1;
            false ->
                maps:put(R, Last, New_Seen1)
        end,
    X = New_R rem N,
    Y = New_R div N,

    {{Y, X}, State#state{total = New_Total, seen = New_Seen2, rand = Rand1}}.

reset(State = #state{m = M, n = N}) ->
    #state{m = M, n = N, total = M * N, seen = #{}, rand = rand:seed(now())}.