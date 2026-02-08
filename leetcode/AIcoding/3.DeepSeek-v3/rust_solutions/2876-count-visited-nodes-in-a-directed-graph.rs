impl Solution {
    pub fn count_visited_nodes(edges: Vec<i32>) -> Vec<i32> {
        let n = edges.len();
        let mut res = vec![0; n];
        let mut visited = vec![-1; n];

        for i in 0..n {
            if res[i] == 0 {
                let mut path = Vec::new();
                let mut current = i;
                while visited[current] == -1 && res[current] == 0 {
                    visited[current] = i as i32;
                    path.push(current);
                    current = edges[current] as usize;
                }

                if res[current] != 0 {
                    for &node in &path {
                        res[node] = res[current] + (path.len() as i32 - path.iter().position(|&x| x == node).unwrap() as i32);
                    }
                } else {
                    let cycle_start = path.iter().position(|&x| x == current).unwrap();
                    let cycle_len = path.len() - cycle_start;
                    for j in cycle_start..path.len() {
                        res[path[j]] = cycle_len as i32;
                    }
                    for j in 0..cycle_start {
                        res[path[j]] = (cycle_len + cycle_start - j) as i32;
                    }
                }
            }
        }
        res
    }
}