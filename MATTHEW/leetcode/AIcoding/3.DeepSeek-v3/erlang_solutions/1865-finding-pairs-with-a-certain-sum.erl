-module(finding_pairs).
-export([init/1, add/3, count/2]).

-record(state, {nums1, nums2, freq}).

init(Nums1) ->
    Freq = lists:foldl(fun(Num, Acc) ->
                           dict:update_counter(Num, 1, Acc)
                       end, dict:new(), Num2),
    #state{nums1 = Num1, nums2 = Num2, freq = Freq}.

add(Index, Num, State) ->
    #state{nums2 = Num2, freq = Freq} = State,
    OldNum = lists:nth(Index + 1, Num2),
    NewNum2 = lists:sublist(Num2, Index) ++ [Num] ++ lists:nthtail(Index + 1, Num2),
    NewFreq = dict:update_counter(OldNum, -1, Freq),
    NewFreq2 = dict:update_counter(Num, 1, NewFreq),
    State#state{nums2 = NewNum2, freq = NewFreq2}.

count(Tot, State) ->
    #state{nums1 = Num1, freq = Freq} = State,
    lists:foldl(fun(Num, Acc) ->
                    case dict:find(Tot - Num, Freq) of
                        {ok, Count} -> Acc + Count;
                        error -> Acc
                    end
                end, 0, Num1).