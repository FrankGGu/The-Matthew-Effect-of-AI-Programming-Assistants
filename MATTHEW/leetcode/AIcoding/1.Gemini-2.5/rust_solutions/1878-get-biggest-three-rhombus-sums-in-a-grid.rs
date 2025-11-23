use std::collections::BTreeSet;

impl Solution {
    pub fn get_biggest_three_rhombus_sums(grid: Vec<Vec<i32>>) -> Vec<i32> {
        let m = grid.len();
        let n = grid[0].len();
        let mut sums: BTreeSet<i32> = BTreeSet::new();

        for r in 0..m {
            for c in 0..n {
                // Case s = 0 (single cell)
                sums.insert(grid[r][c]);

                // Case s > 0 (rhombus with a perimeter)
                // s is the distance from the center (r, c) to any of its four vertices.
                // The four vertices are:
                // Top: (r - s, c)
                // Right: (r, c + s)
                // Bottom: (r + s, c)
                // Left: (r, c - s)
                // All these vertices must be within the grid boundaries.
                // This implies:
                // r - s >= 0  => s <= r
                // r + s < m   => s < m - r
                // c - s >= 0  => s <= c
                // c + s < n   => s < n - c
                // So, s must be less than or equal to the minimum of these four distances.
                let max_s_for_center = *[r, m - 1 - r, c, n - 1 - c].iter().min().unwrap();

                for s in 1..=max_s_for_center {
                    let mut current_sum = 0;

                    // Sum the cells along the four sides of the rhombus perimeter.
                    // We need to be careful not to double-count the vertices.
                    // Approach: Iterate along each side, ensuring vertices are counted only once.

                    // Path 1: From Top vertex (r-s, c) to Right vertex (r, c+s)
                    // Coordinates: (r - s + k, c + k) for k from 0 to s
                    for k in 0..=s {
                        current_sum += grid[r - s + k][c + k];
                    }

                    // Path 2: From Right vertex (r, c+s) to Bottom vertex (r+s, c)
                    // Coordinates: (r + k, c + s - k) for k from 1 to s (excluding Right vertex)
                    for k in 1..=s {
                        current_sum += grid[r + k][c + s - k];
                    }

                    // Path 3: From Bottom vertex (r+s, c) to Left vertex (r, c-s)
                    // Coordinates: (r + s - k, c - k) for k from 1 to s (excluding Bottom vertex)
                    for k in 1..=s {
                        current_sum += grid[r + s - k][c - k];
                    }

                    // Path 4: From Left vertex (r, c-s) to Top vertex (r-s, c)
                    // Coordinates: (r - k, c - s + k) for k from 1 to s-1 (excluding Left and Top vertices)
                    for k in 1..s { 
                        current_sum += grid[r - k][c - s + k];
                    }

                    sums.insert(current_sum);
                }
            }
        }

        // Convert the BTreeSet (which keeps elements sorted) to a Vec.
        // Reverse the order to get descending sums, and take up to the top 3.
        sums.into_iter().rev().take(3).collect()
    }
}