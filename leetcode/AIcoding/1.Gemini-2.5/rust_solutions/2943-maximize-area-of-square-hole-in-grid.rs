use std::collections::HashSet;
use std::cmp::max;

impl Solution {
    pub fn maximize_square_hole_area(n: i32, m: i32, h_bars: Vec<i32>, v_bars: Vec<i32>) -> i32 {
        // Helper function to find the maximum length of consecutive available bars.
        // `total_bars_count` refers to the upper bound of 1-indexed bar indices (e.g., n+1 for horizontal bars).
        // `removed_bars` is a list of 1-indexed bar indices that have been removed.
        let get_max_consecutive_available_length = |total_bars_count: i32, removed_bars: &Vec<i32>| -> i32 {
            let removed_set: HashSet<i32> = removed_bars.iter().cloned().collect();

            let mut max_consecutive_len = 0;
            let mut current_consecutive_len = 0;

            // Bars are 1-indexed, from 1 up to total_bars_count.
            for i in 1..=total_bars_count {
                if !removed_set.contains(&i) {
                    current_consecutive_len += 1;
                } else {
                    max_consecutive_len = max(max_consecutive_len, current_consecutive_len);
                    current_consecutive_len = 0;
                }
            }
            // After the loop, update max_consecutive_len one last time
            // to account for a consecutive sequence ending at total_bars_count.
            max_consecutive_len = max(max_consecutive_len, current_consecutive_len);

            max_consecutive_len
        };

        // Calculate the maximum number of consecutive available horizontal bar indices.
        // There are n+1 horizontal bars, indexed 1 to n+1.
        let max_consecutive_h_bars = get_max_consecutive_available_length(n + 1, &h_bars);

        // Calculate the maximum number of consecutive available vertical bar indices.
        // There are m+1 vertical bars, indexed 1 to m+1.
        let max_consecutive_v_bars = get_max_consecutive_available_length(m + 1, &v_bars);

        // According to the problem statement: "A square hole of side k requires k+1 consecutive available horizontal bars".
        // If we have `L` consecutive available bars, then `L = k + 1`, which means the side length `k = L - 1`.
        // We take `max(0, ...)` to ensure the side length is not negative if `L` is 0 or 1.
        let side_length_from_h_bars = max(0, max_consecutive_h_bars - 1);
        let side_length_from_v_bars = max(0, max_consecutive_v_bars - 1);

        // The maximum side length of a square hole is limited by the minimum of the
        // side lengths achievable in the horizontal and vertical directions.
        let max_side = std::cmp::min(side_length_from_h_bars, side_length_from_v_bars);

        // The area of the square hole is side * side.
        max_side * max_side
    }
}