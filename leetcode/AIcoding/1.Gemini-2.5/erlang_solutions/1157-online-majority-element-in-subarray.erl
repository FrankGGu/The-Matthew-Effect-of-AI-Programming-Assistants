-module(majority_checker).
-export([new/1, query/4]).

-record(state, {
    arr_array :: array:array(),
    val_indices_map :: map(), % #{integer() => array:array(integer())}, where array elements are sorted indices
    rand_state :: rand:state()
}).

new(Arr) ->
    ArrArray = array:from_list(Arr),
    InitialValIndices = build_initial_val_indices(Arr),
    ValIndicesMap = maps:fold(
        fun(Val, IndicesList, AccMap) ->
            maps:put(Val, array:from_list(IndicesList), AccMap)
        end,
        #{},
        InitialValIndices
    ),
    RandState = rand:seed_s_make_ref(),
    #state{arr_array = ArrArray, val_indices_map = ValIndicesMap, rand_state = RandState}.

build_initial_val_indices(Arr) ->
    build_initial_val_indices(Arr, 0, #{}).

build_initial_val_indices([], _Idx, Acc) -> Acc;
build_initial_val_indices([H|T], Idx, Acc) ->
    UpdatedAcc = maps:update_with(H, fun(List) -> List ++ [Idx] end, [Idx], Acc),
    build_initial_val_indices(T, Idx + 1, UpdatedAcc).

query(#state{arr_array = ArrArray, val_indices_map = ValIndicesMap, rand_state = RandState0} = State, Left, Right, Threshold) ->
    NumCandidates = 20,
    RangeLen = Right - Left + 1,
    query_loop(NumCandidates, RangeLen, Left, Right, Threshold, ArrArray, ValIndicesMap, RandState0).

query_loop(0, _RangeLen, _Left, _Right, _Threshold, _ArrArray, _ValIndicesMap, _RandState) ->
    -1;
query_loop(N, RangeLen, Left, Right, Threshold, ArrArray, ValIndicesMap, RandState0) ->
    {RandOffset, RandState1} = rand:uniform_s_int(RangeLen, RandState0),
    ActualRandIdx = Left + RandOffset - 1,

    CandidateVal = array:get(ActualRandIdx, ArrArray),

    CandidateIndicesArray = maps:get(CandidateVal, ValIndicesMap, array:new()),
    Count = count_in_range(CandidateIndicesArray, Left, Right),

    if
        Count >= Threshold -> CandidateVal;
        true -> query_loop(N - 1, RangeLen, Left, Right, Threshold, ArrArray, ValIndicesMap, RandState1)
    end.

count_in_range(SortedIndicesArray, Left, Right) ->
    Upper = upper_bound_impl(SortedIndicesArray, Right),
    Lower = lower_bound_impl(SortedIndicesArray, Left),
    Upper - Lower.

lower_bound_impl(Array, Value) ->
    lower_bound_recursive(Array, Value, 0, array:size(Array)).

lower_bound_recursive(_Array, _Value, Low, High) when Low >= High -> Low;
lower_bound_recursive(Array, Value, Low, High) ->
    Mid = Low + (High - Low) div 2,
    Element = array:get(Mid, Array),
    if
        Element < Value -> lower_bound_recursive(Array, Value, Mid + 1, High);
        true -> lower_bound_recursive(Array, Value, Low, Mid)
    end.

upper_bound_impl(Array, Value) ->
    upper_bound_recursive(Array, Value, 0, array:size(Array)).

upper_bound_recursive(_Array, _Value, Low, High) when Low >= High -> High;
upper_bound_recursive(Array, Value, Low, High) ->
    Mid = Low + (High - Low) div 2,
    Element = array:get(Mid, Array),
    if
        Element <= Value -> upper_bound_recursive(Array, Value, Mid + 1, High);
        true -> upper_bound_recursive(Array, Value, Low, Mid)
    end.