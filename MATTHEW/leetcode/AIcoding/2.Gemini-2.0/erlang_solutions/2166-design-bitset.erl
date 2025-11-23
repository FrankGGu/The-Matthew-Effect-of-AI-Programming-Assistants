-module(bitset).
-export([new/1, fix/2, unfix/2, flip/0, all/0, one/0, size/0, count/0, toString/0]).

-record(state, {bits = <<>>, size, count = 0, flipped = false}).

new(Size) ->
    State = #state{size = Size, bits = list_to_binary(lists:duplicate(Size, 0))},
    {ok, State}.

fix(I, State) ->
    case get_bit(I, State) of
        0 ->
            NewCount = State#state.count + 1,
            NewState = State#state{count = NewCount},
            {ok, set_bit(I, NewState, 1)};
        1 ->
            {ok, State}
    end.

unfix(I, State) ->
    case get_bit(I, State) of
        1 ->
            NewCount = State#state.count - 1,
            NewState = State#state{count = NewCount},
            {ok, set_bit(I, NewState, 0)};
        0 ->
            {ok, State}
    end.

flip(State) ->
    NewFlipped = not State#state.flipped,
    NewState = State#state{flipped = NewFlipped, count = State#state.size - State#state.count},
    {ok, NewState}.

all(State) ->
    {ok, State#state.count =:= State#state.size}.

one(State) ->
    {ok, State#state.count > 0}.

size(State) ->
    {ok, State#state.size}.

count(State) ->
    {ok, State#state.count}.

toString(State) ->
    Bits = binary_to_list(State#state.bits),
    FlippedBits = lists:map(fun(B) -> if State#state.flipped, 1 - B, B end end, Bits),
    {ok, lists:map(fun(B) -> integer_to_list(B) end, FlippedBits)}.

get_bit(I, State) ->
    byte_size(State#state.bits) - 1 -> ByteIndex;
    I rem 8 -> BitIndex
end,
    Byte = binary:part(State#state.bits, {ByteIndex, 1}),
    Bit = (Byte band (1 bsl (7 - BitIndex))) bsr (7 - BitIndex),
    if State#state.flipped, 1 - Bit, Bit end.

set_bit(I, State, Value) ->
    {ByteIndex, BitIndex} = case I of
    I div 8 -> ByteIndex;
    I rem 8 -> BitIndex
end,
    Byte = binary:part(State#state.bits, {ByteIndex, 1}),
    OriginalByte = list_to_integer(binary_to_list(Byte)),
    AdjustedValue = if State#state.flipped, 1 - Value, Value end,
    NewByte = case AdjustedValue of
        0 -> OriginalByte band (255 - (1 bsl (7 - BitIndex)));
        1 -> OriginalByte bor (1 bsl (7 - BitIndex))
    end,
    NewBits = binary:replace(State#state.bits, <<(list_to_integer(binary_to_list(Byte))):8>>, <<NewByte:8>>, [{global, true}]),
    State#state{bits = NewBits}.