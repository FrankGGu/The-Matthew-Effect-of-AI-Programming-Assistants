impl Solution {
    pub fn find_champion(n: i32, edges: Vec<Vec<i32>>) -> i32 {
        let mut in_degree = vec![0; n as usize];
        for edge in edges {
            let to = edge[1] as usize;
            in_degree[to] += 1;
        }
        let mut candidates = Vec::new();
        for i in 0..n as usize {
            if in_degree[i] == 0 {
                candidates.push(i as i32);
            }
        }
        if candidates.len() == 1 {
            candidates[0]
        } else {
            -1
        }
    }
}