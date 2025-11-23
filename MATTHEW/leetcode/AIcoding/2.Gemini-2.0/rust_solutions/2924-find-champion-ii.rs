impl Solution {
    pub fn find_champion(n: i32, edges: Vec<Vec<i32>>) -> i32 {
        let mut indegree = vec![0; n as usize];
        for edge in &edges {
            indegree[edge[1] as usize] += 1;
        }
        let mut champion = -1;
        for i in 0..n as usize {
            if indegree[i] == 0 {
                if champion == -1 {
                    champion = i as i32;
                } else {
                    return -1;
                }
            }
        }
        champion
    }
}