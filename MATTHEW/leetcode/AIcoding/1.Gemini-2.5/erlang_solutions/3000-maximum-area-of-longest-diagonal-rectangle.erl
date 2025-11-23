-module(solution).
-export([longest_diagonal_rectangle/1]).

longest_diagonal_rectangle(Rectangles) ->
    {_MaxDiagonalSquared, MaxArea} = lists:foldl(
        fun([L, W], {CurrentMaxDiagSq, CurrentMaxArea}) ->
            DiagonalSq = L*L + W*W,
            Area = L*W,
            if
                DiagonalSq > CurrentMaxDiagSq ->
                    {DiagonalSq, Area};
                DiagonalSq == CurrentMaxDiagSq ->
                    {CurrentMaxDiagSq, max(CurrentMaxArea, Area)};
                true -> % DiagonalSq < CurrentMaxDiagSq
                    {CurrentMaxDiagSq, CurrentMaxArea}
            end
        end,
        {0, 0}, % Initial state: {MaxDiagonalSquared, MaxArea}
        Rectangles
    ),
    MaxArea.