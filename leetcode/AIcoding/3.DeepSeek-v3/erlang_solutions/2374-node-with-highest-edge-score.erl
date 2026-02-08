-spec edge_score(Edges :: [integer()]) -> integer().
edge_score(Edges) ->
    Scores = maps:new(),
    {MaxScore, Result} = lists:foldl(
        fun(Node, {CurrentMax, CurrentNode}) ->
            ToNode = lists:nth(Node + 1, Edges),
            NewScores = maps:update_with(ToNode, fun(Score) -> Score + Node end, Node, Scores),
            Score = maps:get(ToNode, NewScores, 0),
            case Score > CurrentMax of
                true -> {Score, ToNode};
                false when Score =:= CurrentMax andalso ToNode < CurrentNode -> {Score, ToNode};
                _ -> {CurrentMax, CurrentNode}
            end
        end,
        {-1, -1},
        lists:seq(0, length(Edges) - 1)
    ),
    Result.