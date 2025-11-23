use std::collections::{HashMap, VecDeque};

impl Solution {
    pub fn build_matrix(k: i32, row_conditions: Vec<Vec<i32>>, col_conditions: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        fn topological_sort(k: i32, conditions: Vec<Vec<i32>>) -> Option<Vec<i32>> {
            let mut graph: HashMap<i32, Vec<i32>> = HashMap::new();
            let mut in_degree: HashMap<i32, i32> = HashMap::new();

            for i in 1..=k {
                in_degree.insert(i, 0);
            }

            for cond in conditions {
                let (u, v) = (cond[0], cond[1]);
                graph.entry(u).or_default().push(v);
                *in_degree.entry(v).or_default() += 1;
            }

            let mut queue = VecDeque::new();
            for (&u, &degree) in &in_degree {
                if degree == 0 {
                    queue.push_back(u);
                }
            }

            let mut order = Vec::new();
            while let Some(u) = queue.pop_front() {
                order.push(u);
                if let Some(neighbors) = graph.get(&u) {
                    for &v in neighbors {
                        let entry = in_degree.entry(v).or_default();
                        *entry -= 1;
                        if *entry == 0 {
                            queue.push_back(v);
                        }
                    }
                }
            }

            if order.len() == k as usize {
                Some(order)
            } else {
                None
            }
        }

        let row_order = topological_sort(k, row_conditions);
        let col_order = topological_sort(k, col_conditions);

        if row_order.is_none() || col_order.is_none() {
            return vec![];
        }

        let row_order = row_order.unwrap();
        let col_order = col_order.unwrap();

        let mut row_pos = HashMap::new();
        for (i, &num) in row_order.iter().enumerate() {
            row_pos.insert(num, i);
        }

        let mut col_pos = HashMap::new();
        for (i, &num) in col_order.iter().enumerate() {
            col_pos.insert(num, i);
        }

        let mut matrix = vec![vec![0; k as usize]; k as usize];
        for num in 1..=k {
            let r = row_pos[&num];
            let c = col_pos[&num];
            matrix[r][c] = num;
        }

        matrix
    }
}