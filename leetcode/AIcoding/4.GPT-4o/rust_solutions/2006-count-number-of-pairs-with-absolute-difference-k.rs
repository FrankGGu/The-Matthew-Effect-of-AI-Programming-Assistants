impl Solution {
    pub fn count_k_difference(nums: Vec<i32>, k: i32) -> i32 {
        let mut count = 0;
        let n = nums.len();
        for i in 0..n {
            for j in (i + 1)..n {
                if (nums[i] - nums[j]).abs() == k {
                    count += 1;
                }
            }
        }
        count
    }
}