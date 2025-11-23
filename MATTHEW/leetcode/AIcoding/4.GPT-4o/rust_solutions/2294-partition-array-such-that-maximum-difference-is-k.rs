impl Solution {
    pub fn partition_array(nums: Vec<i32>, k: i32) -> i32 {
        let mut nums = nums;
        nums.sort();
        let mut count = 1;
        let mut start = nums[0];

        for &num in &nums {
            if num - start > k {
                count += 1;
                start = num;
            }
        }

        count
    }
}