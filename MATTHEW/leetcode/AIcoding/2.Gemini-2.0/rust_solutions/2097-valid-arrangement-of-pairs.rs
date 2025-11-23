impl Solution {
    pub fn valid_arrangement(pairs: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        use std::collections::{HashMap, HashSet};

        let mut graph: HashMap<i32, Vec<i32>> = HashMap::new();
        let mut in_degree: HashMap<i32, i32> = HashMap::new();
        let mut out_degree: HashMap<i32, i32> = HashMap::new();

        for pair in &pairs {
            let u = pair[0];
            let v = pair[1];

            graph.entry(u).or_insert(Vec::new()).push(v);
            *out_degree.entry(u).or_insert(0) += 1;
            *in_degree.entry(v).or_insert(0) += 1;
        }

        let mut start_node = pairs[0][0];
        let mut found_start = false;
        for &u in out_degree.keys() {
            let out_val = *out_degree.get(&u).unwrap_or(&0);
            let in_val = *in_degree.get(&u).unwrap_or(&0);

            if out_val - in_val == 1 {
                start_node = u;
                found_start = true;
                break;
            }
        }

        if !found_start {
            for &u in out_degree.keys() {
                start_node = u;
                break;
            }
        }

        let mut result: Vec<Vec<i32>> = Vec::new();
        let mut stack: Vec<i32> = Vec::new();
        stack.push(start_node);

        while !stack.is_empty() {
            let u = *stack.last().unwrap();

            if graph.contains_key(&u) && !graph[&u].is_empty() {
                let v = graph.get_mut(&u).unwrap().remove(0);
                stack.push(v);
            } else {
                stack.pop();
                if !stack.is_empty() {
                    result.push(vec![u, *stack.last().unwrap()]);
                }
            }
        }

        result.reverse();
        result
    }
}