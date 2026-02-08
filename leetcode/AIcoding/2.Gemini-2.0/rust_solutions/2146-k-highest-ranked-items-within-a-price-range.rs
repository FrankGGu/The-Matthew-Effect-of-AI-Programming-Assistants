use std::collections::BinaryHeap;
use std::cmp::Ordering;

#[derive(PartialEq, Eq)]
struct Item {
    rank: (i32, i32, i32),
    row: i32,
    col: i32,
}

impl Ord for Item {
    fn cmp(&self, other: &Self) -> Ordering {
        other.rank.cmp(&self.rank)
    }
}

impl PartialOrd for Item {
    fn partial_cmp(&self, other: &Self) -> Option<Ordering> {
        Some(self.cmp(other))
    }
}

impl Solution {
    pub fn highest_ranked_k_items(
        grid: Vec<Vec<i32>>,
        pricing: Vec<i32>,
        start: Vec<i32>,
        k: i32,
    ) -> Vec<Vec<i32>> {
        let m = grid.len() as i32;
        let n = grid[0].len() as i32;
        let low = pricing[0];
        let high = pricing[1];
        let start_row = start[0];
        let start_col = start[1];

        let mut visited = vec![vec![false; n as usize]; m as usize];
        let mut queue = std::collections::VecDeque::new();
        queue.push_back((start_row, start_col, 0));
        visited[start_row as usize][start_col as usize] = true;

        let mut heap = BinaryHeap::new();

        while let Some((row, col, dist)) = queue.pop_front() {
            let price = grid[row as usize][col as usize];
            if price >= low && price <= high {
                heap.push(Item {
                    rank: (dist, price, -(row + col)),
                    row,
                    col,
                });
            }

            let directions = [(0, 1), (0, -1), (1, 0), (-1, 0)];
            for (dr, dc) in directions {
                let new_row = row + dr;
                let new_col = col + dc;

                if new_row >= 0 && new_row < m && new_col >= 0 && new_col < n &&
                   grid[new_row as usize][new_col as usize] != 0 &&
                   !visited[new_row as usize][new_col as usize] {
                    queue.push_back((new_row, new_col, dist + 1));
                    visited[new_row as usize][new_col as usize] = true;
                }
            }
        }

        let mut result = Vec::new();
        for _ in 0..k {
            if let Some(item) = heap.pop() {
                result.push(vec![item.row, item.col]);
            } else {
                break;
            }
        }

        result
    }
}