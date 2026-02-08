use std::collections::{HashMap, HashSet, VecDeque};

impl Solution {
    pub fn build_matrix(k: i32, row_conditions: Vec<Vec<i32>>, col_conditions: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let k = k as usize;

        fn topological_sort(k: usize, conditions: &Vec<Vec<i32>>) -> Option<Vec<usize>> {
            let mut in_degree = vec![0; k];
            let mut adj = vec![Vec::new(); k];

            for condition in conditions {
                adj[(condition[0] - 1) as usize].push((condition[1] - 1) as usize);
                in_degree[(condition[1] - 1) as usize] += 1;
            }

            let mut queue = VecDeque::new();
            for i in 0..k {
                if in_degree[i] == 0 {
                    queue.push_back(i);
                }
            }

            let mut result = Vec::new();
            while let Some(u) = queue.pop_front() {
                result.push(u);
                for &v in &adj[u] {
                    in_degree[v] -= 1;
                    if in_degree[v] == 0 {
                        queue.push_back(v);
                    }
                }
            }

            if result.len() == k {
                Some(result)
            } else {
                None
            }
        }

        let row_order = match topological_sort(k, &row_conditions) {
            Some(order) => order,
            None => return vec![],
        };

        let col_order = match topological_sort(k, &col_conditions) {
            Some(order) => order,
            None => return vec![],
        };

        let mut row_pos = HashMap::new();
        for (i, &row) in row_order.iter().enumerate() {
            row_pos.insert(row, i);
        }

        let mut result = vec![vec![0; k]; k];
        for (j, &col) in col_order.iter().enumerate() {
            let row_index = row_pos[&col];
            result[row_index][j] = (col as i32) + 1;
        }

        result
    }
}