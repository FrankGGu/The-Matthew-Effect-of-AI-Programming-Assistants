use std::collections::VecDeque;

impl Solution {
    pub fn longest_special_path(n: i32, edges: Vec<Vec<i32>>, values: Vec<i32>) -> i32 {
        let n = n as usize;
        let mut adj: Vec<Vec<usize>> = vec![vec![]; n];
        for edge in &edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
        }

        let mut max_len = -1;

        for start_node in 0..n {
            let mut queue: VecDeque<(usize, i32, Vec<usize>)> = VecDeque::new();
            queue.push_back((start_node, values[start_node], vec![start_node]));

            while let Some((curr_node, curr_xor, path)) = queue.pop_front() {
                if curr_xor == 0 {
                    max_len = max_len.max(path.len() as i32);
                }

                for &neighbor in &adj[curr_node] {
                    if !path.contains(&neighbor) {
                        let mut new_path = path.clone();
                        new_path.push(neighbor);
                        queue.push_back((neighbor, curr_xor ^ values[neighbor], new_path));
                    }
                }
            }
        }

        max_len
    }
}