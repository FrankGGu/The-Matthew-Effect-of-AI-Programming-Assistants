impl Solution {
    pub fn mice_and_cheese(reward1: Vec<i32>, reward2: Vec<i32>, k: i32) -> i32 {
        let n = reward1.len();
        let k_usize = k as usize;

        let mut differences: Vec<i32> = Vec::with_capacity(n);
        for i in 0..n {
            differences.push(reward1[i] - reward2[i]);
        }

        differences.sort_unstable_by(|a, b| b.cmp(a));

        let mut total_score = 0;

        for r2 in reward2.iter() {
            total_score += r2;
        }

        for i in 0..k_usize {
            total_score += differences[i];
        }

        total_score
    }
}