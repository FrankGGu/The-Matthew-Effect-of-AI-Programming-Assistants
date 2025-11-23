impl Solution {

use std::collections::HashMap;

struct Solution;

impl Solution {
    pub fn genetic_difference_queries(mut queries: Vec<Vec<i32>>, root: i32, _tree: Vec<Vec<i32>>) -> Vec<i32> {
        let mut tree = HashMap::new();
        for edge in _tree.iter() {
            tree.entry(edge[0]).or_insert_with(Vec::new).push(edge[1]);
            tree.entry(edge[1]).or_insert_with(Vec::new).push(edge[0]);
        }

        let mut result = Vec::new();
        let mut values = vec![0; 100000];
        let mut max_val = 0;
        let mut min_val = 0;

        fn dfs(
            node: i32,
            parent: i32,
            tree: &HashMap<i32, Vec<i32>>,
            values: &mut Vec<i32>,
            value: i32,
            max_val: &mut i32,
            min_val: &mut i32,
        ) {
            values[node as usize] = value;
            *max_val = std::cmp::max(*max_val, value);
            *min_val = std::cmp::min(*min_val, value);

            for &child in tree.get(&node).unwrap_or(&vec![]) {
                if child != parent {
                    dfs(child, node, tree, values, value ^ 1, max_val, min_val);
                }
            }
        }

        for query in queries {
            let (u, v) = (query[0], query[1]);
            let mut max_val = 0;
            let mut min_val = 0;
            dfs(u, -1, &tree, &mut values, 0, &mut max_val, &mut min_val);
            result.push(max_val ^ min_val);
        }

        result
    }
}
}