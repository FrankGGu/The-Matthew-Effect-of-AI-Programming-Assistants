use std::collections::BinaryHeap;
use std::cmp::Reverse;

struct Solution;

impl Solution {
    pub fn trap_rain_water(height_map: Vec<Vec<i32>>) -> i32 {
        let m = height_map.len();
        if m == 0 {
            return 0;
        }
        let n = height_map[0].len();
        if n == 0 {
            return 0;
        }

        if m <= 2 || n <= 2 {
            return 0;
        }

        let mut visited = vec![vec![false; n]; m];
        let mut min_heap = BinaryHeap::new(); // Stores Reverse((height, row, col))

        // Add border cells to the min-heap
        // Top and bottom rows
        for j in 0..n {
            min_heap.push(Reverse((height_map[0][j], 0, j)));
            visited[0][j] = true;
            min_heap.push(Reverse((height_map[m - 1][j], m - 1, j)));
            visited[m - 1][j] = true;
        }
        // Left and right columns (excluding corners already added)
        for i in 1..m - 1 {
            min_heap.push(Reverse((height_map[i][0], i, 0)));
            visited[i][0] = true;
            min_heap.push(Reverse((height_map[i][n - 1], i, n - 1)));
            visited[i][n - 1] = true;
        }

        let mut total_water = 0;
        let directions = [(0, 1), (0, -1), (1, 0), (-1, 0)];

        while let Some(Reverse((h, r, c))) = min_heap.pop() {
            for (dr, dc) in directions.iter() {
                let nr = (r as isize + dr) as usize;
                let nc = (c as isize + dc) as usize;

                if nr < m && nc < n && !visited[nr][nc] {
                    visited[nr][nc] = true;
                    total_water += (0).max(h - height_map[nr][nc]);
                    min_heap.push(Reverse((h.max(height_map[nr][nc]), nr, nc)));
                }
            }
        }

        total_water
    }
}