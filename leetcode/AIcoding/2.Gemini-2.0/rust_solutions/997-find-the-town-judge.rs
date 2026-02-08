impl Solution {
    pub fn find_judge(n: i32, trust: Vec<Vec<i32>>) -> i32 {
        let mut in_degree = vec![0; n as usize + 1];
        let mut out_degree = vec![0; n as usize + 1];

        for t in &trust {
            out_degree[t[0] as usize] += 1;
            in_degree[t[1] as usize] += 1;
        }

        for i in 1..=n {
            if in_degree[i as usize] == n - 1 && out_degree[i as usize] == 0 {
                return i;
            }
        }

        -1
    }
}