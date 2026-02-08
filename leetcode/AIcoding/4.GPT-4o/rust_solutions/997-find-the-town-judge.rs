impl Solution {
    pub fn find_judge(n: i32, trust: Vec<Vec<i32>>) -> i32 {
        let mut trust_count = vec![0; (n + 1) as usize];

        for t in trust {
            trust_count[t[0] as usize] -= 1;
            trust_count[t[1] as usize] += 1;
        }

        for i in 1..=n {
            if trust_count[i as usize] == n - 1 {
                return i;
            }
        }

        -1
    }
}