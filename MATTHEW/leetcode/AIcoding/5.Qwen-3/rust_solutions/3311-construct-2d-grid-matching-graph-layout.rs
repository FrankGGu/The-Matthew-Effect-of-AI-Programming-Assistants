impl Solution {

use std::collections::{HashMap, VecDeque};

impl Solution {
    pub fn move_submarines(grid: Vec<Vec<char>>) -> Vec<Vec<i32>> {
        let rows = grid.len();
        let cols = grid[0].len();
        let mut result = vec![vec![0; cols]; rows];

        let mut positions = Vec::new();
        for i in 0..rows {
            for j in 0..cols {
                if grid[i][j] == 'S' {
                    positions.push((i, j));
                }
            }
        }

        let mut graph = HashMap::new();
        for (i, j) in &positions {
            let key = (*i, *j);
            graph.insert(key, Vec::new());
        }

        for (i, j) in &positions {
            let neighbors = vec![
                (i - 1, j),
                (i + 1, j),
                (i, j - 1),
                (i, j + 1),
            ];
            for (ni, nj) in neighbors {
                if ni >= 0 && ni < rows as i32 && nj >= 0 && nj < cols as i32 {
                    let neighbor = (ni, nj);
                    if grid[ni as usize][nj as usize] == 'S' {
                        graph.get_mut(&(*i, *j)).unwrap().push(neighbor);
                    }
                }
            }
        }

        let mut visited = HashMap::new();
        for (i, j) in &positions {
            visited.insert((*i, *j), false);
        }

        for (i, j) in &positions {
            if !visited[&(*i, *j)] {
                let mut queue = VecDeque::new();
                queue.push_back((*i, *j));
                visited.insert((*i, *j), true);
                let mut nodes = Vec::new();
                nodes.push((*i, *j));

                while let Some(node) = queue.pop_front() {
                    for &neighbor in graph.get(&node).unwrap() {
                        if !visited[&neighbor] {
                            visited.insert(neighbor, true);
                            queue.push_back(neighbor);
                            nodes.push(neighbor);
                        }
                    }
                }

                let size = nodes.len();
                for (k, &pos) in nodes.iter().enumerate() {
                    result[pos.0 as usize][pos.1 as usize] = k as i32;
                }
            }
        }

        result
    }
}
}