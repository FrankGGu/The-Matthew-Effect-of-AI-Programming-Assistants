use std::collections::HashMap;

impl Solution {
    pub fn num_of_minutes(n: i32, head_id: i32, manager: Vec<i32>, inform_time: Vec<i32>) -> i32 {
        let mut graph: HashMap<i32, Vec<i32>> = HashMap::new();
        for (i, &m) in manager.iter().enumerate() {
            if m != -1 {
                graph.entry(m).or_insert(Vec::new()).push(i as i32);
            }
        }

        fn dfs(node: i32, graph: &HashMap<i32, Vec<i32>>, inform_time: &Vec<i32>) -> i32 {
            let mut max_time = 0;
            if let Some(subordinates) = graph.get(&node) {
                for &sub in subordinates {
                    max_time = max_time.max(dfs(sub, graph, inform_time));
                }
            }
            max_time + inform_time[node as usize]
        }

        dfs(head_id, &graph, &inform_time)
    }
}