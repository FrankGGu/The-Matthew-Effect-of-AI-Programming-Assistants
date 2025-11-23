use std::collections::HashMap;

impl Solution {
    pub fn maximize_number_of_target_nodes(edges: Vec<Vec<i32>>, target: Vec<i32>) -> i32 {
        let n = target.len();
        let mut adj: HashMap<i32, Vec<i32>> = HashMap::new();
        let mut in_degree = vec![0; n];

        for edge in &edges {
            let u = edge[0];
            let v = edge[1];
            adj.entry(u).or_insert(Vec::new()).push(v);
            in_degree[v as usize] += 1;
        }

        let mut memo: HashMap<i32, (i32, i32)> = HashMap::new();

        fn solve(
            node: i32,
            target: &Vec<i32>,
            adj: &HashMap<i32, Vec<i32>>,
            memo: &mut HashMap<i32, (i32, i32)>,
        ) -> (i32, i32) {
            if let Some(&result) = memo.get(&node) {
                return result;
            }

            let mut with_node = 0;
            let mut without_node = 0;

            if let Some(children) = adj.get(&node) {
                for &child in children {
                    let (with_child, without_child) = solve(child, target, adj, memo);
                    with_node += without_child;
                    without_node += with_child.max(without_child);
                }
            }

            if target[node as usize] == 1 {
                with_node += 1;
            }

            memo.insert(node, (with_node, without_node));
            (with_node, without_node)
        }

        let mut result = 0;
        for i in 0..n {
            if in_degree[i] == 0 {
                let (with_root, without_root) = solve(i as i32, &target, &adj, &mut memo);
                result += with_root.max(without_root);
            }
        }

        result
    }
}