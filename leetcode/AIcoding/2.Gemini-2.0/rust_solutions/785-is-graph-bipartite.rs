impl Solution {
    pub fn is_bipartite(graph: Vec<Vec<i32>>) -> bool {
        let n = graph.len();
        let mut colors = vec![0; n];

        for i in 0..n {
            if colors[i] == 0 {
                let mut queue = std::collections::VecDeque::new();
                queue.push_back(i);
                colors[i] = 1;

                while !queue.is_empty() {
                    let u = queue.pop_front().unwrap();
                    for &v_i32 in &graph[u] {
                        let v = v_i32 as usize;
                        if colors[v] == 0 {
                            colors[v] = -colors[u];
                            queue.push_back(v);
                        } else if colors[v] == colors[u] {
                            return false;
                        }
                    }
                }
            }
        }

        true
    }
}