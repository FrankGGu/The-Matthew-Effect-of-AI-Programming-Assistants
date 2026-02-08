-module(solution).
-export([minimumBuckets/1]).

minimumBuckets(Hamsters) ->
    HamstersList = string:to_list(Hamsters),
    N = length(HamstersList),

    solve_recursive(0, N, HamstersList, 0, gb_sets:new()).

solve_recursive(I, N, HamstersList, Buckets, BucketPositions) when I >= N ->
    Buckets;
solve_recursive(I, N, HamstersList, Buckets, BucketPositions) ->
    Char = lists:nth(I + 1, HamstersList), % lists:nth is 1-based, I is 0-based

    case Char of
        $H ->
            % Check if already fed by a bucket at I-1
            % A bucket at I-1 would have been placed at a '.' position.
            % So, check if I-1 is in BucketPositions.
            AlreadyFedByLeftBucket = (I > 0) andalso gb_sets:is_member(I - 1, BucketPositions),

            if AlreadyFedByLeftBucket ->
                % Hamster at I is already fed by a bucket at I-1. Move to the next position.
                solve_recursive(I + 1, N, HamstersList, Buckets, BucketPositions);
            else
                % Hamster at I needs a bucket.
                % Prioritize placing a bucket at I+1 to cover future hamsters.
                if (I + 1 < N) andalso (lists:nth(I + 2, HamstersList) == $.) -> % Check if I+1 is an empty spot
                    NewBuckets = Buckets + 1,
                    NewBucketPositions = gb_sets:add(I + 1, BucketPositions), % Store 0-based index
                    % This bucket at I+1 feeds hamsters at I and I+2.
                    % So, we can skip I+1 (where bucket is placed) and I+2 (which is now fed).
                    % Advance I to I+3.
                    solve_recursive(I + 3, N, HamstersList, NewBuckets, NewBucketPositions);
                % If I+1 is not available (out of bounds or 'H'), try to place at I-1.
                else if (I > 0) andalso (lists:nth(I, HamstersList) == $.) -> % Check if I-1 is an empty spot
                    NewBuckets = Buckets + 1,
                    NewBucketPositions = gb_sets:add(I - 1, BucketPositions), % Store 0-based index
                    % This bucket at I-1 feeds hamsters at I and I-2.
                    % We just advance I to I+1. I-1 and I-2 are already processed or not hamsters.
                    solve_recursive(I + 1, N, HamstersList, NewBuckets, NewBucketPositions);
                else
                    % Cannot feed this hamster (neither I+1 nor I-1 is a suitable empty spot).
                    -1
                end
            end;
        $. ->
            % Current position is an empty space, just move to the next.
            solve_recursive(I + 1, N, HamstersList, Buckets, BucketPositions)
    end.