impl Solution {
    pub fn longest_cycle(edges: Vec<i32>) -> i32 {
        let n = edges.len();
        let mut visited = vec![false; n];
        let mut on_stack = vec![false; n];
        let mut max_length = -1;

        fn dfs(v: usize, edges: &Vec<i32>, visited: &mut Vec<bool>, on_stack: &mut Vec<bool>, stack: &mut Vec<usize>, max_length: &mut i32) {
            visited[v] = true;
            on_stack[v] = true;
            stack.push(v);
            let next = edges[v];
            if next != -1 {
                let next = next as usize;
                if on_stack[next] {
                    let cycle_length = stack.len() - stack.iter().position(|&x| x == next).unwrap();
                    *max_length = (*max_length).max(cycle_length as i32);
                } else if !visited[next] {
                    dfs(next, edges, visited, on_stack, stack, max_length);
                }
            }
            on_stack[v] = false;
            stack.pop();
        }

        for i in 0..n {
            if !visited[i] {
                let mut stack = Vec::new();
                dfs(i, &edges, &mut visited, &mut on_stack, &mut stack, &mut max_length);
            }
        }

        max_length
    }
}