impl Solution {

use std::collections::{HashMap, VecDeque};

impl Solution {
    pub fn build_matrix(
        k: i32,
        row_conditions: Vec<Vec<i32>>,
        col_conditions: Vec<Vec<i32>>,
    ) -> Vec<Vec<i32>> {
        fn topological_sort(
            n: i32,
            edges: Vec<Vec<i32>>,
        ) -> Option<Vec<i32>> {
            let mut graph = HashMap::new();
            let mut in_degree = vec![0; n as usize];

            for edge in edges {
                let u = edge[0];
                let v = edge[1];
                graph.entry(u).or_insert_with(Vec::new).push(v);
                in_degree[v as usize] += 1;
            }

            let mut queue = VecDeque::new();
            for i in 0..n {
                if in_degree[i as usize] == 0 {
                    queue.push_back(i);
                }
            }

            let mut result = Vec::new();
            while let Some(u) = queue.pop_front() {
                result.push(u);
                if let Some(neighbors) = graph.get(&u) {
                    for &v in neighbors {
                        in_degree[v as usize] -= 1;
                        if in_degree[v as usize] == 0 {
                            queue.push_back(v);
                        }
                    }
                }
            }

            if result.len() as i32 == n {
                Some(result)
            } else {
                None
            }
        }

        let row_order = topological_sort(k, row_conditions);
        let col_order = topological_sort(k, col_conditions);

        match (row_order, col_order) {
            (Some(row_order), Some(col_order)) => {
                let mut matrix = vec![vec![0; k as usize]; k as usize];
                let row_map: HashMap<_, _> = row_order.iter().enumerate().map(|(i, &x)| (x, i)).collect();
                let col_map: HashMap<_, _> = col_order.iter().enumerate().map(|(i, &x)| (x, i)).collect();

                for i in 0..k {
                    for j in 0..k {
                        matrix[i as usize][j as usize] = i * k + j;
                    }
                }

                for i in 0..k {
                    for j in 0..k {
                        let row_idx = row_map[&i];
                        let col_idx = col_map[&j];
                        matrix[row_idx][col_idx] = i * k + j;
                    }
                }

                matrix
            }
            _ => vec![],
        }
    }
}
}