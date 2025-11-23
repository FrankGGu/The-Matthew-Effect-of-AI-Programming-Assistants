impl Solution {
    pub fn find_judge(n: i32, trust: Vec<Vec<i32>>) -> i32 {
        let mut indegree = vec![0; (n + 1) as usize];
        let mut outdegree = vec![0; (n + 1) as usize];

        for t in trust {
            let a = t[0] as usize;
            let b = t[1] as usize;
            outdegree[a] += 1;
            indegree[b] += 1;
        }

        for i in 1..=(n as usize) {
            if outdegree[i] == 0 && indegree[i] == n - 1 {
                return i as i32;
            }
        }

        -1
    }
}