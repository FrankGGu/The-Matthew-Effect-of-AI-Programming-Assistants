-module(image_overlap).
-export([largestOverlap/3]).

largestOverlap(Img1, Img2, N) ->
    largestOverlapHelper(Img1, Img2, N, 0, 0, 0).

largestOverlapHelper(Img1, Img2, N, Row, Col, MaxOverlap) ->
    if Row >= -N + 1 ->
        if Col >= -N + 1 ->
            Overlap = calculateOverlap(Img1, Img2, N, Row, Col),
            NewMaxOverlap = max(MaxOverlap, Overlap),
            largestOverlapHelper(Img1, Img2, N, Row, Col - 1, NewMaxOverlap);
        true ->
            largestOverlapHelper(Img1, Img2, N, Row - 1, -N + 1, MaxOverlap)
    end,
    MaxOverlap.

calculateOverlap(Img1, Img2, N, RowOffset, ColOffset) ->
    calculateOverlapHelper(Img1, Img2, N, RowOffset, ColOffset, 0, 0, 0).

calculateOverlapHelper(Img1, Img2, N, RowOffset, ColOffset, Row, Col, Overlap) ->
    if Row < N ->
        if Col < N ->
            NewRow = Row + RowOffset,
            NewCol = Col + ColOffset,
            if NewRow >= 0 andalso NewRow < N andalso NewCol >= 0 andalso NewCol < N ->
                if lists:nth(Row + 1, Img1) =:= lists:nth(NewRow + 1, Img2) andalso
                   lists:nth(Col + 1, lists:nth(Row + 1, Img1)) =:= lists:nth(NewCol + 1, lists:nth(NewRow + 1, Img2)) andalso
                   lists:nth(Col + 1, lists:nth(Row + 1, Img1)) == 1 ->
                    calculateOverlapHelper(Img1, Img2, N, RowOffset, ColOffset, Row, Col + 1, Overlap + 1);
                true ->
                    calculateOverlapHelper(Img1, Img2, N, RowOffset, ColOffset, Row, Col + 1, Overlap)
            ;
            true ->
                calculateOverlapHelper(Img1, Img2, N, RowOffset, ColOffset, Row, Col + 1, Overlap)
        end,
        calculateOverlapHelper(Img1, Img2, N, RowOffset, ColOffset, Row + 1, 0, Overlap);
    true ->
        Overlap.