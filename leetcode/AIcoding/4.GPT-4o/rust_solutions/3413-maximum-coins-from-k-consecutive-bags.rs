impl Solution {
    pub fn max_coins(bags: Vec<i32>, k: i32) -> i32 {
        let mut bags = bags;
        bags.sort_unstable_by(|a, b| b.cmp(a));
        bags.iter().take(k as usize).sum()
    }
}