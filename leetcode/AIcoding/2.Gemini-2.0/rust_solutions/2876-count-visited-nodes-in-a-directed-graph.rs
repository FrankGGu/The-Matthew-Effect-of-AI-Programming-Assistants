impl Solution {
    pub fn count_visited_nodes(edges: Vec<i32>) -> Vec<i32> {
        let n = edges.len();
        let mut adj: Vec<Vec<usize>> = vec![vec![]; n];
        for i in 0..n {
            adj[i].push(edges[i] as usize);
        }

        let mut ans = vec![0; n];
        for start_node in 0..n {
            let mut visited = vec![false; n];
            let mut path = vec![];
            let mut curr = start_node;

            while !visited[curr] {
                visited[curr] = true;
                path.push(curr);
                curr = adj[curr][0];
            }

            let cycle_start = path.iter().position(|&x| x == curr).unwrap();
            let cycle_len = path.len() - cycle_start;

            for i in 0..cycle_len {
                ans[path[cycle_start + i]] = cycle_len as i32;
            }

            for i in (0..cycle_start).rev() {
                let mut dist = 1;
                let mut curr_node = path[i];
                let mut next_node = path[i + 1];

                while ans[curr_node] == 0 {
                    ans[curr_node] = ans[next_node] + 1;
                    if i > 0 {
                        next_node = path[i];

                    } else {
                        break;
                    }

                    if i > 0{
                        curr_node = path[i - 1];
                    } else {
                        break;
                    }

                    dist += 1;
                }
            }
        }

        ans
    }
}