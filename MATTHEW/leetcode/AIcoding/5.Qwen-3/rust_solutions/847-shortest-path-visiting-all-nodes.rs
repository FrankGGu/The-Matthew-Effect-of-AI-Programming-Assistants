impl Solution {

use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn shortest_path_visit_all_nodes(mut grid: Vec<Vec<i32>>) -> i32 {
        let n = grid.len();
        let mut start = 0;
        for i in 0..n {
            if grid[i][0] == 1 {
                start = i;
                break;
            }
        }

        let target = (1 << n) - 1;

        let mut queue = VecDeque::new();
        let mut visited = HashSet::new();

        queue.push_back((start, 1 << start, 0));
        visited.insert((start, 1 << start));

        while let Some((node, mask, steps)) = queue.pop_front() {
            if mask == target {
                return steps;
            }

            for neighbor in 0..n {
                if grid[node][neighbor] == 1 {
                    let new_mask = mask | (1 << neighbor);
                    if !visited.contains(&(neighbor, new_mask)) {
                        visited.insert((neighbor, new_mask));
                        queue.push_back((neighbor, new_mask, steps + 1));
                    }
                }
            }
        }

        -1
    }
}
}