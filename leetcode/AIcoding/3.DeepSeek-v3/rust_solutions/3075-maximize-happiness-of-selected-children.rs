impl Solution {
    pub fn maximum_happiness_sum(happiness: Vec<i32>, k: i32) -> i64 {
        let mut happiness = happiness;
        happiness.sort_by(|a, b| b.cmp(a));
        let mut sum: i64 = 0;
        for i in 0..k as usize {
            let current = happiness[i] as i64 - i as i64;
            if current > 0 {
                sum += current;
            }
        }
        sum
    }
}