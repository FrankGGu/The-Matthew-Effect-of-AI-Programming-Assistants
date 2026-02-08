-module(solution).
-export([alphabet_board_path/1]).

char_to_pos($z) -> {5, 0};
char_to_pos(Char) ->
    Index = Char - $a,
    {Index div 5, Index rem 5}.

generate_moves({CR, CC}, {TR, TC}) ->
    if
        TR == 5 andalso TC == 0 ->
            lists:duplicate(CC, $L) ++ lists:duplicate(5 - CR, $D);
        CR == 5 andalso CC == 0 ->
            lists:duplicate(5 - TR, $U) ++ lists:duplicate(TC, $R);
        true ->
            VerticalMoves = if CR > TR -> lists:duplicate(CR - TR, $U);
                              CR < TR -> lists:duplicate(TR - CR, $D);
                              true -> []
                            end,
            HorizontalMoves = if CC > TC -> lists:duplicate(CC - TC, $L);
                               CC < TC -> lists:duplicate(TC - CC, $R);
                               true -> []
                             end,
            VerticalMoves ++ HorizontalMoves
    end.

alphabet_board_path(Target) ->
    {_FinalPos, PathList} = lists:foldl(
        fun(Char, {CurrentPos, AccPath}) ->
            TargetPos = char_to_pos(Char),
            Moves = generate_moves(CurrentPos, TargetPos),
            {TargetPos, AccPath ++ Moves ++ [$!]}
        end,
        {{0,0}, []},
        Target
    ),
    PathList.