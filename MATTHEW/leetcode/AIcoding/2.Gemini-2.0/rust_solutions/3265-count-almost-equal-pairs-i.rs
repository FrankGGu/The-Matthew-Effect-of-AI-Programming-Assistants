impl Solution {
    pub fn count_almost_equal_pairs(nums: Vec<i32>, diff: i32) -> i32 {
        let mut count = 0;
        for i in 0..nums.len() {
            for j in (i + 1)..nums.len() {
                if (nums[i] - nums[j]).abs() <= diff {
                    count += 1;
                }
            }
        }
        count
    }
}