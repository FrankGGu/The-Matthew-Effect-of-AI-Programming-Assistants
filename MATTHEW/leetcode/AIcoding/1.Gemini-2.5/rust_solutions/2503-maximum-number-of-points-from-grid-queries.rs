use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn max_points(grid: Vec<Vec<i32>>, queries: Vec<i32>) -> Vec<i32> {
        let m = grid.len();
        let n = grid[0].len();

        let mut indexed_queries: Vec<(i32, usize)> = queries
            .into_iter()
            .enumerate()
            .map(|(i, q_val)| (q_val, i))
            .collect();
        indexed_queries.sort_unstable(); // Sort queries by value in ascending order

        let mut ans = vec![0; indexed_queries.len()];

        // Priority queue stores (cell_value, row, col)
        // We use Reverse to make BinaryHeap act as a min-priority queue
        let mut pq: BinaryHeap<Reverse<(i32, usize, usize)>> = BinaryHeap::new();
        let mut visited = vec![vec![false; n]; m];

        // Start at (0,0). Push its value, row, and col to the PQ.
        // The value grid[0][0] is the "cost" to enter this cell.
        pq.push(Reverse((grid[0][0], 0, 0)));

        let dr = [-1, 1, 0, 0];
        let dc = [0, 0, -1, 1];

        let mut reachable_count = 0;

        for (q_val, original_idx) in indexed_queries {
            // Process cells from PQ whose values are strictly less than the current query's value
            while let Some(Reverse((cell_val, r, c))) = pq.peek() {
                if *cell_val >= q_val {
                    // This cell, and all subsequent cells in the PQ (due to min-heap property),
                    // have values too high for the current query. Break and process next query.
                    break;
                }

                // If cell_val < q_val, pop it and process it
                let Reverse((_, r, c)) = pq.pop().unwrap();

                if visited[r][c] {
                    // Already visited and counted, skip
                    continue;
                }

                // Mark as visited and increment count
                visited[r][c] = true;
                reachable_count += 1;

                // Add unvisited neighbors to PQ
                for i in 0..4 {
                    let nr = r as isize + dr[i];
                    let nc = c as isize + dc[i];

                    if nr >= 0 && nr < m as isize && nc >= 0 && nc < n as isize {
                        let nr = nr as usize;
                        let nc = nc as usize;
                        if !visited[nr][nc] {
                            pq.push(Reverse((grid[nr][nc], nr, nc)));
                        }
                    }
                }
            }
            // Store the current reachable count for this query
            ans[original_idx] = reachable_count;
        }

        ans
    }
}