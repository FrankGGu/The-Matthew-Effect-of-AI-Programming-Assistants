-module(solution).
-export([edge_score/1]).

edge_score(Edges) ->
    N = length(Edges),

    % Initialize an array of N zeros for scores.
    % array:new([{size, N}, {fixed, true}]) creates an array of N elements,
    % defaulting to the 'default' value (which is undefined if not specified).
    % However, array:set will handle first assignment correctly.
    % For safety, we can explicitly set default to 0.
    ScoreArray0 = array:new([{size, N}, {fixed, true}, {default, 0}]),

    % Create a list of {TargetNode, SourceIndex} pairs.
    % SourceIndex ranges from 0 to N-1.
    IndexedEdges = lists:zip(Edges, lists:seq(0, N-1)),

    % Iterate through the indexed edges and update the scores in ScoreArray.
    % lists:foldl is used to accumulate the updated ScoreArray.
    ScoreArrayFinal = lists:foldl(
        fun({TargetNode, SourceIndex}, CurrentScoreArray) ->
            % Get the current score for the TargetNode
            CurrentScore = array:get(TargetNode, CurrentScoreArray),
            % Update the score by adding the SourceIndex
            array:set(TargetNode, CurrentScore + SourceIndex, CurrentScoreArray)
        end,
        ScoreArray0,
        IndexedEdges
    ),

    % Find the node with the highest score.
    % If there's a tie, return the smallest indexed node.
    % array:foldl iterates through the array with (Index, Element, Acc)
    % Acc is {MaxScoreFoundSoFar, MaxNodeIndexFoundSoFar}.
    % Initial state {0, 0} is safe because scores are non-negative and node 0 is a valid index.
    {_MaxScore, MaxNodeIndex} = array:foldl(
        fun(NodeIndex, Score, {MaxScoreAcc, MaxNodeIndexAcc}) ->
            if
                Score > MaxScoreAcc ->
                    % New highest score found, update both score and index
                    {Score, NodeIndex};
                Score == MaxScoreAcc ->
                    % Same highest score, keep the smaller index (MaxNodeIndexAcc is already smaller due to iteration order)
                    {MaxScoreAcc, MaxNodeIndexAcc};
                true -> % Score < MaxScoreAcc
                    % Current score is not higher, keep previous max
                    {MaxScoreAcc, MaxNodeIndexAcc}
            end
        end,
        {0, 0}, % Initial maximum score 0 for node 0.
        ScoreArrayFinal
    ),
    MaxNodeIndex.