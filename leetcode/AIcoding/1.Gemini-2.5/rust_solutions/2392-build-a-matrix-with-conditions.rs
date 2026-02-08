use std::collections::VecDeque;

impl Solution {
    pub fn build_matrix(k: i32, row_conditions: Vec<Vec<i32>>, col_conditions: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let k_usize = k as usize;

        fn get_topological_order(k: usize, conditions: Vec<Vec<i32>>) -> Vec<usize> {
            let mut adj: Vec<Vec<usize>> = vec![vec![]; k + 1];
            let mut in_degree: Vec<i32> = vec![0; k + 1];

            for condition in conditions {
                let u = condition[0] as usize;
                let v = condition[1] as usize;
                adj[u].push(v);
                in_degree[v] += 1;
            }

            let mut q: VecDeque<usize> = VecDeque::new();
            for i in 1..=k {
                if in_degree[i] == 0 {
                    q.push_back(i);
                }
            }

            let mut order: Vec<usize> = Vec::new();
            while let Some(u) = q.pop_front() {
                order.push(u);
                for &v in &adj[u] {
                    in_degree[v] -= 1;
                    if in_degree[v] == 0 {
                        q.push_back(v);
                    }
                }
            }

            if order.len() == k {
                order
            } else {
                Vec::new()
            }
        }

        let row_order = get_topological_order(k_usize, row_conditions);
        if row_order.is_empty() {
            return vec![];
        }

        let col_order = get_topological_order(k_usize, col_conditions);
        if col_order.is_empty() {
            return vec![];
        }

        let mut row_pos: Vec<usize> = vec![0; k_usize + 1];
        for (i, &num) in row_order.iter().enumerate() {
            row_pos[num] = i;
        }

        let mut col_pos: Vec<usize> = vec![0; k_usize + 1];
        for (i, &num) in col_order.iter().enumerate() {
            col_pos[num] = i;
        }

        let mut matrix: Vec<Vec<i32>> = vec![vec![0; k_usize]; k_usize];
        for num in 1..=k_usize {
            matrix[row_pos[num]][col_pos[num]] = num as i32;
        }

        matrix
    }
}