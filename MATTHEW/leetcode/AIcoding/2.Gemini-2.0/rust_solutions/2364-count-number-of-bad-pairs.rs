impl Solution {
    pub fn count_bad_pairs(nums: Vec<i32>) -> i64 {
        let n = nums.len();
        let mut count = 0;
        for i in 0..n {
            for j in (i + 1)..n {
                if nums[j] - nums[i] != (j as i32 - i as i32) {
                    count += 1;
                }
            }
        }
        count as i64
    }
}