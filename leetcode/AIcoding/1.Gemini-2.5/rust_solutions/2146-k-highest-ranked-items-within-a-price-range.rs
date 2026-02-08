use std::collections::VecDeque;

impl Solution {
    pub fn highest_ranked_items(grid: Vec<Vec<i32>>, price_range: Vec<i32>, start: Vec<i32>, k: i32) -> Vec<Vec<i32>> {
        let m = grid.len();
        let n = grid[0].len();
        let low_price = price_range[0];
        let high_price = price_range[1];

        let mut queue: VecDeque<(i32, i32, i32)> = VecDeque::new(); // (r, c, dist)
        let mut visited: Vec<Vec<bool>> = vec![vec![false; n]; m];
        let mut ranked_items: Vec<(i32, i32, i32, i32)> = Vec::new(); // (dist, price, r, c)

        let start_r = start[0];
        let start_c = start[1];

        queue.push_back((start_r, start_c, 0));
        visited[start_r as usize][start_c as usize] = true;

        let dr = [-1, 1, 0, 0];
        let dc = [0, 0, -1, 1];

        while let Some((r, c, dist)) = queue.pop_front() {
            let price = grid[r as usize][c as usize];

            // Check if current cell contains an item within the price range.
            // An item is represented by a positive integer greater than 1.
            // A floor is represented by 1.
            if price > 1 && price >= low_price && price <= high_price {
                ranked_items.push((dist, price, r, c));
            }

            // Explore neighbors
            for i in 0..4 {
                let nr = r + dr[i];
                let nc = c + dc[i];

                // Check bounds
                if nr >= 0 && nr < m as i32 && nc >= 0 && nc < n as i32 {
                    // Check if not visited and not an obstacle (0)
                    if !visited[nr as usize][nc as usize] && grid[nr as usize][nc as usize] != 0 {
                        visited[nr as usize][nc as usize] = true;
                        queue.push_back((nr, nc, dist + 1));
                    }
                }
            }
        }

        // Sort the items based on the specified criteria:
        // 1. distance (ascending)
        // 2. price (ascending)
        // 3. row (ascending)
        // 4. col (ascending)
        ranked_items.sort_unstable_by(|a, b| {
            if a.0 != b.0 { // Compare distance
                a.0.cmp(&b.0)
            } else if a.1 != b.1 { // Compare price
                a.1.cmp(&b.1)
            } else if a.2 != b.2 { // Compare row
                a.2.cmp(&b.2)
            } else { // Compare col
                a.3.cmp(&b.3)
            }
        });

        // Collect the top k items (or fewer if less than k are available)
        ranked_items.into_iter()
            .take(k as usize)
            .map(|item| vec![item.2, item.3])
            .collect()
    }
}