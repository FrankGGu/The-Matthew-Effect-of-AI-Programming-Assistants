use std::collections::{VecDeque, HashMap};

impl Solution {
    pub fn possible_bipartition(n: i32, dislikes: Vec<Vec<i32>>) -> bool {
        let n = n as usize;
        let mut graph = vec![vec![]; n + 1];
        for pair in dislikes {
            let a = pair[0] as usize;
            let b = pair[1] as usize;
            graph[a].push(b);
            graph[b].push(a);
        }

        let mut color = vec![0; n + 1];
        for i in 1..=n {
            if color[i] == 0 {
                let mut queue = VecDeque::new();
                queue.push_back(i);
                color[i] = 1;
                while let Some(u) = queue.pop_front() {
                    for &v in &graph[u] {
                        if color[v] == 0 {
                            color[v] = if color[u] == 1 { 2 } else { 1 };
                            queue.push_back(v);
                        } else if color[v] == color[u] {
                            return false;
                        }
                    }
                }
            }
        }
        true
    }
}