pub fn build_matrix(k: i32, row_conditions: Vec<Vec<i32>>, col_conditions: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
    use std::collections::HashMap;
    use std::collections::VecDeque;

    fn topological_sort(n: i32, conditions: &Vec<Vec<i32>>) -> Vec<i32> {
        let mut graph: HashMap<i32, Vec<i32>> = HashMap::new();
        let mut indegree = vec![0; (n + 1) as usize];

        for condition in conditions {
            let u = condition[0];
            let v = condition[1];
            graph.entry(u).or_insert_with(Vec::new).push(v);
            indegree[v as usize] += 1;
        }

        let mut queue = VecDeque::new();
        for i in 1..=n {
            if indegree[i as usize] == 0 {
                queue.push_back(i);
            }
        }

        let mut order = Vec::new();
        while let Some(node) = queue.pop_front() {
            order.push(node);
            if let Some(neighbors) = graph.get(&node) {
                for &neighbor in neighbors {
                    indegree[neighbor as usize] -= 1;
                    if indegree[neighbor as usize] == 0 {
                        queue.push_back(neighbor);
                    }
                }
            }
        }

        if order.len() == n as usize {
            order
        } else {
            Vec::new()
        }
    }

    let row_order = topological_sort(k, &row_conditions);
    let col_order = topological_sort(k, &col_conditions);

    if row_order.is_empty() || col_order.is_empty() {
        return vec![];
    }

    let mut matrix = vec![vec![0; k as usize]; k as usize];
    let mut position = vec![0; (k + 1) as usize];

    for i in 0..row_order.len() {
        position[row_order[i] as usize] = i + 1;
    }

    for j in 0..col_order.len() {
        let col_idx = position[col_order[j] as usize] - 1;
        matrix[col_idx][j] = col_order[j];
    }

    matrix
}