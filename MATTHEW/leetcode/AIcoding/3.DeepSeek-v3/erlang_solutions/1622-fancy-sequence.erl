-module(fancy).

-export([init/0, append/2, add_all/2, mult_all/2, get_index/2]).

-record(state, {seq = [], add = 0, mul = 1}).

init() ->
    #state{}.

append(State, Val) ->
    #state{seq = Seq, add = Add, mul = Mul} = State,
    NewVal = (Val - Add) * pow(Mul, 1000000005, 1000000007) rem 1000000007,
    State#state{seq = Seq ++ [NewVal]}.

add_all(State, Inc) ->
    #state{add = Add} = State,
    State#state{add = (Add + Inc) rem 1000000007}.

mult_all(State, M) ->
    #state{add = Add, mul = Mul} = State,
    NewAdd = (Add * M) rem 1000000007,
    NewMul = (Mul * M) rem 1000000007,
    State#state{add = NewAdd, mul = NewMul}.

get_index(State, Idx) ->
    #state{seq = Seq, add = Add, mul = Mul} = State,
    case Idx >= length(Seq) of
        true -> -1;
        false ->
            Val = lists:nth(Idx + 1, Seq),
            (Val * Mul + Add) rem 1000000007
    end.

pow(_, 0, _) -> 1;
pow(A, B, Mod) ->
    case B rem 2 of
        0 -> pow((A * A) rem Mod, B div 2, Mod);
        1 -> (A * pow((A * A) rem Mod, B div 2, Mod)) rem Mod
    end.