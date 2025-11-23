impl Solution {
    pub fn count_target(scores: Vec<i32>, target: i32) -> i32 {
        scores.iter().filter(|&&x| x == target).count() as i32
    }
}