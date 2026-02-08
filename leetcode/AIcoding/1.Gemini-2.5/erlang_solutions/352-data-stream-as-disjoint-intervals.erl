-module(summary_ranges).
-export([new/0, add_num/2, get_intervals/1]).

-record(state, {intervals = gb_trees:empty()}).

new() ->
    #state{intervals = gb_trees:empty()}.

add_num(Num, #state{intervals = Tree}) ->
    % 1. Check if Num is already covered by an existing interval
    case gb_trees:lookup_le(Num, Tree) of
        {value, S, E} when Num >= S andalso Num <= E ->
            % Num is already covered, return the original state
            #state{intervals = Tree};
        _ ->
            % Num is not covered, proceed to merge it
            CurrentS = Num,
            CurrentE = Num,
            UpdatedTree = Tree,

            % Check for merge with left neighbor
            {MergedS, T1} =
                case gb_trees:lookup_le(Num - 1, UpdatedTree) of
                    {value, S_left, E_left} when E_left =:= Num - 1 ->
                        % Num merges with the interval {S_left, E_left}
                        {S_left, gb_trees:delete(S_left, UpdatedTree)};
                    _ ->
                        {CurrentS, UpdatedTree}
                end,

            % Check for merge with right neighbor
            {MergedE, T2} =
                case gb_trees:lookup(Num + 1, T1) of
                    {value, S_right, E_right} ->
                        % Num merges with the interval {S_right, E_right}
                        {E_right, gb_trees:delete(S_right, T1)};
                    _ ->
                        {CurrentE, T1}
                end,

            % Insert the new (merged) interval
            NewTree = gb_trees:insert(MergedS, MergedE, T2),
            #state{intervals = NewTree}
    end.

get_intervals(#state{intervals = Tree}) ->
    gb_trees:to_list(Tree).