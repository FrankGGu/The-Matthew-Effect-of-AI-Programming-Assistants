use std::collections::{BinaryHeap, VecDeque};

impl Solution {
    pub fn minimum_visited_cells(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();
        if m == 1 && n == 1 {
            return 1;
        }

        let mut dist = vec![vec![i32::MAX; n]; m];
        dist[0][0] = 1;

        let mut row_heaps: Vec<BinaryHeap<(i32, usize)>> = vec![BinaryHeap::new(); m];
        let mut col_heaps: Vec<BinaryHeap<(i32, usize)>> = vec![BinaryHeap::new(); n];

        row_heaps[0].push((-1, 0));
        col_heaps[0].push((-1, 0));

        let mut q = VecDeque::new();
        q.push_back((0, 0));

        while let Some((i, j)) = q.pop_front() {
            let d = dist[i][j];
            let val = grid[i][j] as usize;

            // Right direction
            let start = j + 1;
            let end = (j + val).min(n - 1);
            if start <= end {
                while let Some(&(-pd, k)) = row_heaps[i].peek() {
                    if k < start {
                        row_heaps[i].pop();
                    } else {
                        break;
                    }
                }
                if let Some(&(-pd, k)) = row_heaps[i].peek() {
                    if k <= end && pd + 1 < dist[i][k] {
                        dist[i][k] = pd + 1;
                        q.push_back((i, k));
                        row_heaps[i].push((-(pd + 1), k));
                        col_heaps[k].push((-(pd + 1), i));
                    }
                }
            }

            // Down direction
            let start = i + 1;
            let end = (i + val).min(m - 1);
            if start <= end {
                while let Some(&(-pd, k)) = col_heaps[j].peek() {
                    if k < start {
                        col_heaps[j].pop();
                    } else {
                        break;
                    }
                }
                if let Some(&(-pd, k)) = col_heaps[j].peek() {
                    if k <= end && pd + 1 < dist[k][j] {
                        dist[k][j] = pd + 1;
                        q.push_back((k, j));
                        row_heaps[k].push((-(pd + 1), j));
                        col_heaps[j].push((-(pd + 1), k));
                    }
                }
            }
        }

        if dist[m - 1][n - 1] == i32::MAX {
            -1
        } else {
            dist[m - 1][n - 1]
        }
    }
}