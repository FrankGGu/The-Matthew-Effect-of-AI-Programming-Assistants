-module(solution).
-behaviour(gen_server).

-export([init/1, handle_call/3, handle_cast/2, terminate/2, code_change/3]).
-export([new/1, update/3, sumRange/3]).

-record(state, {
    nums :: array:array(),
    bit :: array:array(),
    size :: integer()
}).

new(Nums) ->
    {ok, Pid} = gen_server:start_link(?MODULE, [Nums], []),
    Pid.

update(Pid, Index, Val) ->
    gen_server:cast(Pid, {update, Index, Val}).

sumRange(Pid, Left, Right) ->
    gen_server:call(Pid, {sumRange, Left, Right}).

init([NumsList]) ->
    Size = length(NumsList),
    NumsArray = array:from_list(NumsList),
    BitArray = array:new([{size, Size + 1}, {fixed, true}, {default, 0}]),
    InitialBit = build_bit(NumsArray, BitArray, Size),
    {ok, #state{nums = NumsArray, bit = InitialBit, size = Size}}.

handle_cast({update, Index, Val}, State = #state{nums = NumsArray, bit = BitArray, size = Size}) ->
    OldVal = array:get(Index, NumsArray),
    Delta = Val - OldVal,
    NewNumsArray = array:set(Index, Val, NumsArray),
    NewBitArray = update_bit_internal(BitArray, Index + 1, Delta, Size),
    {noreply, State#state{nums = NewNumsArray, bit = NewBitArray}};
handle_cast(_Msg, State) ->
    {noreply, State}.

handle_call({sumRange, Left, Right}, _From, State = #state{bit = BitArray, size = Size}) ->
    SumRight = query_bit_internal(BitArray, Right + 1, Size),
    SumLeftMinusOne = query_bit_internal(BitArray, Left, Size),
    {reply, SumRight - SumLeftMinusOne, State};
handle_call(_Msg, _From, State) ->
    {reply, {error, bad_request}, State}.

terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

build_bit(NumsArray, BitArray, Size) ->
    lists:foldl(fun(I, CurrentBit) ->
        Val = array:get(I, NumsArray),
        update_bit_internal(CurrentBit, I + 1, Val, Size)
    end, BitArray, lists:seq(0, Size - 1)).

update_bit_internal(BitArray, Index, Delta, Size) ->
    update_bit_loop(BitArray, Index, Delta, Size).

update_bit_loop(BitArray, I, Delta, Size) when I =< Size ->
    CurrentVal = array:get(I, BitArray),
    NewBitArray = array:set(I, CurrentVal + Delta, BitArray),
    NextI = I + (I band -I),
    update_bit_loop(NewBitArray, NextI, Delta, Size);
update_bit_loop(BitArray, _I, _Delta, _Size) ->
    BitArray.

query_bit_internal(BitArray, Index, _Size) ->
    query_bit_loop(BitArray, Index, 0).

query_bit_loop(BitArray, I, Sum) when I > 0 ->
    CurrentVal = array:get(I, BitArray),
    NextI = I - (I band -I),
    query_bit_loop(BitArray, NextI, Sum + CurrentVal);
query_bit_loop(_BitArray, _I, Sum) ->
    Sum.