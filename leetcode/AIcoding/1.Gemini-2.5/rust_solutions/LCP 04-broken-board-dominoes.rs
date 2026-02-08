use std::collections::HashMap;

struct Solution;

impl Solution {
    pub fn domino_tiling(board: Vec<String>) -> i32 {
        let m = board.len();
        let n = board[0].len();
        let grid: Vec<Vec<char>> = board.iter().map(|s| s.chars().collect()).collect();

        let mut left_nodes_map: HashMap<(usize, usize), usize> = HashMap::new();
        let mut right_nodes_map: HashMap<(usize, usize), usize> = HashMap::new();
        let mut left_node_count = 0;
        let mut right_node_count = 0;

        for r in 0..m {
            for c in 0..n {
                if grid[r][c] == '.' {
                    if (r + c) % 2 == 0 {
                        left_nodes_map.insert((r, c), left_node_count);
                        left_node_count += 1;
                    } else {
                        right_nodes_map.insert((r, c), right_node_count);
                        right_node_count += 1;
                    }
                }
            }
        }

        let mut adj: Vec<Vec<usize>> = vec![vec![]; left_node_count];
        let dr = [-1, 1, 0, 0];
        let dc = [0, 0, -1, 1];

        for r in 0..m {
            for c in 0..n {
                if grid[r][c] == '.' && (r + c) % 2 == 0 {
                    let u = *left_nodes_map.get(&(r, c)).unwrap();

                    for i in 0..4 {
                        let nr = r as isize + dr[i];
                        let nc = c as isize + dc[i];

                        if nr >= 0 && nr < m as isize && nc >= 0 && nc < n as isize {
                            let nr = nr as usize;
                            let nc = nc as usize;

                            if grid[nr][nc] == '.' && (nr + nc) % 2 == 1 {
                                let v = *right_nodes_map.get(&(nr, nc)).unwrap();
                                adj[u].push(v);
                            }
                        }
                    }
                }
            }
        }

        let mut match_r: Vec<i32> = vec![-1; right_node_count];
        let mut result = 0;

        for u in 0..left_node_count {
            let mut visited: Vec<bool> = vec![false; left_node_count];
            if Self::dfs_augment(u, &adj, &mut visited, &mut match_r) {
                result += 1;
            }
        }

        result
    }

    fn dfs_augment(
        u: usize,
        adj: &Vec<Vec<usize>>,
        visited: &mut Vec<bool>,
        match_r: &mut Vec<i32>,
    ) -> bool {
        visited[u] = true;

        for &v in &adj[u] {
            if match_r[v] == -1 || (!visited[match_r[v] as usize] && Self::dfs_augment(match_r[v] as usize, adj, visited, match_r)) {
                match_r[v] = u as i32;
                return true;
            }
        }
        false
    }
}