-module(fancy_sequence).
-export([new/0, addVal/2, addAll/2, multAll/2, getIndex/2]).

-define(MOD, 1000000007).

-record(fs_state, {elements, size, global_mult, global_add}).

new() ->
    #fs_state{elements = #{}, size = 0, global_mult = 1, global_add = 0}.

addVal(#fs_state{elements = Elements, size = Size, global_mult = GM, global_add = GA} = State, Val) ->
    NewElements = maps:put(Size, {Val, GM, GA}, Elements),
    State#fs_state{elements = NewElements, size = Size + 1}.

addAll(#fs_state{global_add = GA} = State, Inc) ->
    NewGA = (GA + Inc) rem ?MOD,
    State#fs_state{global_add = NewGA}.

multAll(#fs_state{global_mult = GM, global_add = GA} = State, M) ->
    NewGM = (GM * M) rem ?MOD,
    NewGA = (GA * M) rem ?MOD,
    State#fs_state{global_mult = NewGM, global_add = NewGA}.

getIndex(#fs_state{elements = Elements, size = Size, global_mult = GM_current, global_add = GA_current}, Idx) ->
    if Idx >= Size ->
        -1;
    true ->
        case maps:get(Idx, Elements, undefined) of
            undefined ->
                -1;
            {Val_at_add, GM_at_add, GA_at_add} ->
                Inv_GM_at_add = power(GM_at_add, ?MOD - 2, ?MOD),

                M_delta = (GM_current * Inv_GM_at_add) rem ?MOD,

                Term_GA_at_add_M_delta = (GA_at_add * M_delta) rem ?MOD,
                A_delta = (GA_current - Term_GA_at_add_M_delta + ?MOD) rem ?MOD,

                Term_Val_at_add_M_delta = (Val_at_add * M_delta) rem ?MOD,
                Result = (Term_Val_at_add_M_delta + A_delta) rem ?MOD,
                Result
        end
    end.

power(_Base, 0, _Mod, Acc) -> Acc;
power(Base, Exp, Mod, Acc) ->
    NewAcc = if Exp rem 2 == 1 -> (Acc * Base) rem Mod;
                true -> Acc
             end,
    NewBase = (Base * Base) rem Mod,
    power(NewBase, Exp div 2, Mod, NewAcc).