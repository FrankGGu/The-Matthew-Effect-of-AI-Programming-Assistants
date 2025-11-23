use std::collections::HashMap;

impl Solution {
    pub fn longest_special_path(path: Vec<String>) -> i32 {
        let mut graph: HashMap<String, Vec<String>> = HashMap::new();
        let mut in_degree: HashMap<String, i32> = HashMap::new();

        for p in &path {
            let parts: Vec<&str> = p.split('/').collect();
            for i in 0..parts.len() - 1 {
                let u = parts[i].to_string();
                let v = parts[i + 1].to_string();
                graph.entry(u.clone()).or_default().push(v.clone());
                *in_degree.entry(v).or_insert(0) += 1;
                in_degree.entry(u).or_insert(0);
            }
        }

        let mut queue: Vec<String> = Vec::new();
        for (node, &degree) in &in_degree {
            if degree == 0 {
                queue.push(node.clone());
            }
        }

        let mut max_depth = 0;
        let mut depth: HashMap<String, i32> = HashMap::new();

        while !queue.is_empty() {
            let u = queue.pop().unwrap();
            let current_depth = *depth.get(&u).unwrap_or(&0);
            max_depth = max_depth.max(current_depth);

            if let Some(neighbors) = graph.get(&u) {
                for v in neighbors {
                    let entry = depth.entry(v.clone()).or_insert(0);
                    *entry = (*entry).max(current_depth + 1);
                    let deg = in_degree.get_mut(v).unwrap();
                    *deg -= 1;
                    if *deg == 0 {
                        queue.push(v.clone());
                    }
                }
            }
        }

        max_depth + 1
    }
}