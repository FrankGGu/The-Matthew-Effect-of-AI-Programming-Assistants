impl Solution {
    pub fn maximum_count(nums: Vec<i32>) -> i32 {
        let mut pos_count = 0;
        let mut neg_count = 0;
        for &num in &nums {
            if num > 0 {
                pos_count += 1;
            } else if num < 0 {
                neg_count += 1;
            }
        }
        std::cmp::max(pos_count, neg_count)
    }
}