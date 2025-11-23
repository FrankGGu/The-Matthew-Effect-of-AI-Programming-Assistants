use std::cmp::{max, min};

impl Solution {
    pub fn max_building_height(n: i32, restrictions: Vec<Vec<i32>>) -> i32 {
        let mut points: Vec<(i32, i32)> = Vec::new();
        points.push((0, 0)); // Virtual building at position 0 with height 0

        for r in restrictions {
            points.push((r[0], r[1]));
        }

        // Sort points by position (building ID)
        points.sort_unstable();

        // Forward pass: Adjust max heights based on left neighbors
        // For each building `i`, its height `h_i` must satisfy `h_i <= h_{i-1} + (p_i - p_{i-1})`
        // and `h_i <= initial_max_height`.
        for i in 1..points.len() {
            let prev_pos = points[i - 1].0;
            let prev_height = points[i - 1].1;
            let curr_pos = points[i].0;
            let curr_height_max = points[i].1;

            points[i].1 = min(curr_height_max, prev_height + (curr_pos - prev_pos));
        }

        // Backward pass: Adjust max heights based on right neighbors
        // For each building `i`, its height `h_i` must satisfy `h_i <= h_{i+1} + (p_{i+1} - p_i)`
        // and its current `max_height` (already adjusted by forward pass).
        for i in (0..points.len() - 1).rev() {
            let next_pos = points[i + 1].0;
            let next_height = points[i + 1].1;
            let curr_pos = points[i].0;
            let curr_height_max = points[i].1;

            points[i].1 = min(curr_height_max, next_height + (next_pos - curr_pos));
        }

        let mut max_overall_height = 0;

        // Calculate max height for segments between adjacent restricted buildings
        // After the two passes, points[i].1 contains the maximum possible height for building points[i].0
        // that satisfies all restrictions.
        // For any building `j` between `p1` and `p2`, its height `h_j` is limited by:
        // `h_j <= h1 + (p_j - p1)` and `h_j <= h2 + (p2 - p_j)`.
        // The maximum of `min(h1 + (p_j - p1), h2 + (p2 - p_j))` occurs at the "peak"
        // and is given by `(h1 + h2 + (p2 - p1)) / 2`.
        for i in 0..points.len() - 1 {
            let p1 = points[i].0;
            let h1 = points[i].1;
            let p2 = points[i + 1].0;
            let h2 = points[i + 1].1;

            let dist = p2 - p1;
            let max_h_between_segment = (h1 + h2 + dist) / 2;
            max_overall_height = max(max_overall_height, max_h_between_segment);
        }

        // Finally, consider the segment from the last restricted building to building `n`.
        // If building `n` is not restricted, its height can increase by 1 per unit distance
        // from the last restricted building, up to `n`.
        let last_p = points.last().unwrap().0;
        let last_h = points.last().unwrap().1;
        max_overall_height = max(max_overall_height, last_h + (n - last_p));

        max_overall_height
    }
}