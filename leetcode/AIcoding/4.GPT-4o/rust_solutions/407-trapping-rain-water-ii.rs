use std::collections::BinaryHeap;

impl Solution {
    pub fn trap_rain_water(height: Vec<Vec<i32>>) -> i32 {
        let m = height.len();
        let n = height[0].len();
        let mut visited = vec![vec![false; n]; m];
        let mut heap = BinaryHeap::new();
        let mut water = 0;

        for i in 0..m {
            for j in 0..n {
                if i == 0 || i == m - 1 || j == 0 || j == n - 1 {
                    visited[i][j] = true;
                    heap.push(std::cmp::Reverse(height[i][j]));
                }
            }
        }

        let directions = vec![(0, 1), (1, 0), (0, -1), (-1, 0)];

        while let Some(std::cmp::Reverse(h)) = heap.pop() {
            for (di, dj) in &directions {
                let ni = i as isize + di;
                let nj = j as isize + dj;
                if ni >= 0 && ni < m as isize && nj >= 0 && nj < n as isize {
                    let ni = ni as usize;
                    let nj = nj as usize;
                    if !visited[ni][nj] {
                        visited[ni][nj] = true;
                        water += h - height[ni][nj].max(h);
                        heap.push(std::cmp::Reverse(height[ni][nj].max(h)));
                    }
                }
            }
        }

        water
    }
}