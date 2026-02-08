impl Solution {
    pub fn transportation_hub(path: Vec<Vec<i32>>) -> i32 {
        use std::collections::{HashMap, HashSet};
        let mut in_degree: HashMap<i32, usize> = HashMap::new();
        let mut out_degree: HashMap<i32, usize> = HashMap::new();
        let mut nodes: HashSet<i32> = HashSet::new();

        for edge in &path {
            let u = edge[0];
            let v = edge[1];
            *out_degree.entry(u).or_insert(0) += 1;
            *in_degree.entry(v).or_insert(0) += 1;
            nodes.insert(u);
            nodes.insert(v);
        }

        let n = nodes.len();
        for (&node, &cnt) in in_degree.iter() {
            if cnt == n - 1 && out_degree.get(&node).unwrap_or(&0) == &0 {
                return node;
            }
        }

        -1
    }
}