impl Solution {
    pub fn maximum_beauty(nums: Vec<i32>, k: i32) -> i32 {
        let mut nums = nums;
        nums.sort_unstable();
        let mut max_beauty = 0;
        let n = nums.len();
        let mut j = 0;

        for i in 0..n {
            while j < n && nums[j] <= nums[i] + k {
                j += 1;
            }
            max_beauty = max_beauty.max(j - i);
        }

        max_beauty
    }
}