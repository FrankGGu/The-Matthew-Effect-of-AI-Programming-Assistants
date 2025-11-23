use std::f64;

impl Solution {
    pub fn coordinate_with_max_network_quality(towers: Vec<Vec<i32>>, radius: i32) -> Vec<i32> {
        let mut max_quality = 0;

        // Based on problem constraints: 0 <= xi, yi <= 50 and 0 <= radius <= 50.
        // The relevant search space for (x, y) coordinates is from
        // min(xi) - radius to max(xi) + radius.
        // This translates to 0 - 50 = -50 for the minimum, and 50 + 50 = 100 for the maximum.
        let min_search_coord = -50;
        let max_search_coord = 100;

        // Initialize best_coord to the lexicographically smallest possible point in the search space.
        // This ensures correct tie-breaking if all points yield 0 quality.
        let mut best_coord = vec![min_search_coord, min_search_coord];

        let radius_sq = (radius * radius) as f64;

        for x in min_search_coord..=max_search_coord {
            for y in min_search_coord..=max_search_coord {
                let mut current_quality = 0;
                for tower in &towers {
                    let tx = tower[0];
                    let ty = tower[1];
                    let tq = tower[2];

                    let dx = (x - tx) as f64;
                    let dy = (y - ty) as f64;

                    let dist_sq = dx * dx + dy * dy;

                    if dist_sq <= radius_sq {
                        let d = dist_sq.sqrt();
                        current_quality += (tq as f64 / (1.0 + d)).floor() as i32;
                    }
                }

                if current_quality > max_quality {
                    max_quality = current_quality;
                    best_coord[0] = x;
                    best_coord[1] = y;
                } else if current_quality == max_quality {
                    // Tie-breaking: return the lexicographically smallest coordinate.
                    // (x1, y1) is smaller than (x2, y2) if x1 < x2 or (x1 == x2 and y1 < y2).
                    if x < best_coord[0] || (x == best_coord[0] && y < best_coord[1]) {
                        best_coord[0] = x;
                        best_coord[1] = y;
                    }
                }
            }
        }

        best_coord
    }
}