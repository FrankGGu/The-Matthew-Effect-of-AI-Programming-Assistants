-module(solution).
-export([waysToBuildRooms/2]).

-define(MOD, 1000000007).

power(Base, Exp, Mod) ->
    power_acc(Base, Exp, Mod, 1).

power_acc(_, 0, _, Acc) -> Acc;
power_acc(Base, Exp, Mod, Acc) ->
    NewAcc = if Exp rem 2 == 1 -> (Acc * Base) rem Mod;
                true -> Acc
             end,
    NewBase = (Base * Base) rem Mod,
    power_acc(NewBase, Exp div 2, Mod, NewAcc).

mod_inverse(N, Mod) ->
    power(N, Mod - 2, Mod).

precompute_factorials(N, Mod) ->
    Factorials = array:new([{size, N}, {default, 0}]),
    InvFactorials = array:new([{size, N}, {default, 0}]),

    Factorials_0 = array:set(0, 1, Factorials),

    Facs = precompute_factorials_up(1, N - 1, Mod, Factorials_0),

    InvFacs_N_minus_1 = mod_inverse(array:get(N - 1, Facs), Mod),
    InvFacs_N_minus_1_Set = array:set(N - 1, InvFacs_N_minus_1, InvFactorials),

    InvFacs = precompute_factorials_down(N - 2, 0, Mod, InvFacs_N_minus_1_Set),

    {Facs, InvFacs}.

precompute_factorials_up(I, MaxI, Mod, Factorials) when I =< MaxI ->
    PrevFac = array:get(I - 1, Factorials),
    CurrentFac = (PrevFac * I) rem Mod,
    NewFactorials = array:set(I, CurrentFac, Factorials),
    precompute_factorials_up(I + 1, MaxI, Mod, NewFactorials).
precompute_factorials_up(_, _, _, Factorials) -> Factorials.

precompute_factorials_down(I, MinI, Mod, InvFactorials) when I >= MinI ->
    NextInvFac = array:get(I + 1, InvFactorials),
    CurrentInvFac = (NextInvFac * (I + 1)) rem Mod,
    NewInvFactorials = array:set(I, CurrentInvFac, InvFactorials),
    precompute_factorials_down(I - 1, MinI, Mod, NewInvFactorials).
precompute_factorials_down(_, _, _, InvFactorials) -> InvFactorials.

build_adj(N, PrevRoom) ->
    Adj = array:new([{size, N}, {default, []}]),
    build_adj_loop(1, N - 1, PrevRoom, Adj).

build_adj_loop(I, MaxI, PrevRoom, Adj) when I =< MaxI ->
    Parent = lists:nth(I + 1, PrevRoom), 
    CurrentChildren = array:get(Parent, Adj),
    NewAdj = array:set(Parent, [I | CurrentChildren], Adj),
    build_adj_loop(I + 1, MaxI, PrevRoom, NewAdj).
build_adj_loop(_, _, _, Adj) -> Adj.

dfs(U, Adj, Factorials, InvFactorials, Sizes, DPs, Mod) ->
    Children = array:get(U, Adj),

    {FSAC, FDAC, TCS, PCDS, PCIF} = 
        lists:foldl(fun(Child, {AccS, AccD, AccTCS, AccPCDS, AccPCIF}) ->
                            {NewS, NewD, CS, CD} = dfs(Child, Adj, Factorials, InvFactorials, AccS, AccD, Mod),
                            {NewS, NewD, 
                             AccTCS + CS, 
                             (AccPCDS * CD) rem Mod,
                             (AccPCIF * array:get(CS, InvFactorials)) rem Mod}
                    end, {Sizes, DPs, 0, 1, 1}, Children),

    SU = 1 + TCS, 

    DPU = (PCDS * array:get(SU - 1, Factorials)) rem Mod,
    DPU = (DPU * PCIF) rem Mod,

    US = array:set(U, SU, FSAC),
    UDP = array:set(U, DPU, FDAC),

    {US, UDP, SU, DPU}.

waysToBuildRooms(N, PrevRoom) ->
    Mod = ?MOD,

    {Factorials, InvFactorials} = precompute_factorials(N, Mod),

    Adj = build_adj(N, PrevRoom),

    Sizes = array:new([{size, N}, {default, 0}]),
    DPs = array:new([{size, N}, {default, 0}]),

    {_, FinalDPs, _, _} = dfs(0, Adj, Factorials, InvFactorials, Sizes, DPs, Mod),

    array:get(0, FinalDPs).