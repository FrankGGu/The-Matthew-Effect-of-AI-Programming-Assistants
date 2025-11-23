impl Solution {
    pub fn max_jump(stones: Vec<i32>) -> i32 {
        let mut max_jump = 0;
        for i in 1..stones.len() {
            max_jump = max_jump.max(stones[i] - stones[i - 1]);
        }
        max_jump
    }
}