impl Solution {
    pub fn mice_and_cheese(reward1: Vec<i32>, reward2: Vec<i32>, k: i32) -> i32 {
        let n = reward1.len();
        let mut diffs: Vec<(i32, usize)> = (0..n)
            .map(|i| (reward1[i] - reward2[i], i))
            .collect();
        diffs.sort_by(|a, b| b.0.cmp(&a.0));

        let mut ans = 0;
        for i in 0..k as usize {
            ans += reward1[diffs[i].1];
        }
        for i in k as usize..n {
            ans += reward2[diffs[i].1];
        }
        ans
    }
}