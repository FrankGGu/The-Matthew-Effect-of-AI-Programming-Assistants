struct Solution;

impl Solution {
    pub fn eventual_safe_states(graph: Vec<Vec<i32>>) -> Vec<i32> {
        let n = graph.len();
        // 0: unvisited, 1: visiting (in current DFS path), 2: safe, 3: unsafe
        let mut states: Vec<i8> = vec![0; n];

        let mut result: Vec<i32> = Vec::new();

        for i in 0..n {
            if Self::dfs(i, &graph, &mut states) {
                result.push(i as i32);
            }
        }

        result
    }

    fn dfs(u: usize, graph: &Vec<Vec<i32>>, states: &mut Vec<i8>) -> bool {
        if states[u] == 1 {
            states[u] = 3;
            return false;
        }
        if states[u] == 2 {
            return true;
        }
        if states[u] == 3 {
            return false;
        }

        states[u] = 1;

        for &v_i32 in graph[u].iter() {
            let v = v_i32 as usize;
            if !Self::dfs(v, graph, states) {
                states[u] = 3;
                return false;
            }
        }

        states[u] = 2;
        true
    }
}