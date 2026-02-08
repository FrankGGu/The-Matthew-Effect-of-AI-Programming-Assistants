impl Solution {
    pub fn maximum_white_tiles(tiles: Vec<Vec<i32>>, carpet_len: i32) -> i32 {
        let n = tiles.len();
        if n == 0 {
            return 0;
        }

        let mut max_covered_length: i32 = 0;
        let mut current_window_length: i32 = 0;
        let mut i: usize = 0; // Left pointer for the sliding window

        for j in 0..n { // Right pointer for the sliding window
            // Add the current tile's full length to the window sum
            current_window_length += tiles[j][1] - tiles[j][0] + 1;

            // Calculate the left edge of the carpet if its right edge is placed at tiles[j][1]
            let carpet_left_edge = tiles[j][1] - carpet_len + 1;

            // Shrink the window from the left (advance 'i') if tiles[i] is completely to the left of the carpet
            while tiles[i][1] < carpet_left_edge {
                current_window_length -= tiles[i][1] - tiles[i][0] + 1;
                i += 1;
            }

            // At this point, tiles[i] is the first tile that *could* overlap with the carpet.
            // All tiles from tiles[i] to tiles[j] are potentially covered.
            // `current_window_length` sums the full lengths of tiles from `i` to `j`.

            // Calculate the actual length covered by the carpet.
            // This is `current_window_length` minus any part of `tiles[i]` that is to the left of `carpet_left_edge`.
            let mut covered_by_current_carpet = current_window_length;

            // If the carpet's left edge is to the right of `tiles[i]`'s start,
            // then a part of `tiles[i]` is not covered.
            if carpet_left_edge > tiles[i][0] {
                covered_by_current_carpet -= carpet_left_edge - tiles[i][0];
            }

            max_covered_length = max_covered_length.max(covered_by_current_carpet);
        }

        max_covered_length
    }
}