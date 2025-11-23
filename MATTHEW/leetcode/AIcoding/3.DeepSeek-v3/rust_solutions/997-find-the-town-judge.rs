impl Solution {
    pub fn find_judge(n: i32, trust: Vec<Vec<i32>>) -> i32 {
        let n = n as usize;
        let mut in_degree = vec![0; n + 1];
        let mut out_degree = vec![0; n + 1];

        for t in trust {
            let a = t[0] as usize;
            let b = t[1] as usize;
            out_degree[a] += 1;
            in_degree[b] += 1;
        }

        for i in 1..=n {
            if in_degree[i] == n - 1 && out_degree[i] == 0 {
                return i as i32;
            }
        }

        -1
    }
}