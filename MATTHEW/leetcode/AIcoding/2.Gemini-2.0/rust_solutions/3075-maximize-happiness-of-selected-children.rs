impl Solution {
    pub fn maximize_happiness(happiness: Vec<i32>, k: i32) -> i64 {
        let mut happiness = happiness;
        happiness.sort_unstable_by(|a, b| b.cmp(a));
        let mut ans: i64 = 0;
        for i in 0..k.min(happiness.len() as i32) as usize {
            ans += happiness[i] as i64;
        }
        ans
    }
}