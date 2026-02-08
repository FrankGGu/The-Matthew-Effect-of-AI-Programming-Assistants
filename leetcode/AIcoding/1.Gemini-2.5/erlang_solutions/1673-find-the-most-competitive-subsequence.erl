-module(solution).
-export([mostCompetitive/2]).

mostCompetitive(Nums, K) ->
    L = length(Nums),
    ResultStack = process_nums(Nums, K, L, 0, [], 0),
    lists:reverse(ResultStack).

process_nums([], _K, _L, _Index, AccStack, _AccStackLen) ->
    AccStack;
process_nums([N | T], K, L, Index, AccStack, AccStackLen) ->
    NumsRemainingCount = L - Index,

    {NewAccStack, NewAccStackLen} = pop_stack(AccStack, AccStackLen, N, K, NumsRemainingCount),

    FinalAccStack = if NewAccStackLen < K ->
                        [N | NewAccStack];
                    else
                        NewAccStack
                    end,
    FinalAccStackLen = if NewAccStackLen < K ->
                            NewAccStackLen + 1;
                        else
                            NewAccStackLen
                        end,

    process_nums(T, K, L, Index + 1, FinalAccStack, FinalAccStackLen).

pop_stack(AccStack, AccStackLen, N, K, NumsRemainingCount) ->
    case AccStack of
        [] ->
            {[], 0};
        [Top | Rest] ->
            % Condition to pop:
            % 1. Top of stack is greater than current number N
            % 2. We can still form a subsequence of length K after popping Top
            %    (i.e., (current stack size - 1) + (remaining numbers in Nums including N) >= K)
            %    (AccStackLen - 1) + NumsRemainingCount >= K
            if Top > N andalso (AccStackLen - 1 + NumsRemainingCount >= K) ->
                pop_stack(Rest, AccStackLen - 1, N, K, NumsRemainingCount);
            else
                {AccStack, AccStackLen}
            end
    end.