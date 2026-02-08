-spec find_rotation(Mat :: [[integer()]], Target :: [[integer()]]) -> boolean().
find_rotation(Mat, Target) ->
    case Mat =:= Target of
        true -> true;
        false ->
            Rot90 = rotate90(Mat),
            case Rot90 =:= Target of
                true -> true;
                false ->
                    Rot180 = rotate90(Rot90),
                    case Rot180 =:= Target of
                        true -> true;
                        false ->
                            Rot270 = rotate90(Rot180),
                            Rot270 =:= Target
                    end
            end
    end.

rotate90(Mat) ->
    N = length(Mat),
    [[lists:nth(N - J + 1, lists:nth(I, Mat)) || J <- lists:seq(1, N)] || I <- lists:seq(1, N)].