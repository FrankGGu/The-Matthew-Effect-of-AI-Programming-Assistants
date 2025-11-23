impl Solution {
    pub fn max_difference(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut max_diff = -1;
        for i in 0..n {
            let next = (i + 1) % n;
            let diff = nums[next] - nums[i];
            if diff > max_diff && diff > 0 {
                max_diff = diff;
            }
        }
        max_diff
    }
}