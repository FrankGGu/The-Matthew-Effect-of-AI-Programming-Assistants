impl Solution {
    pub fn largest_sum_after_k_negations(nums: Vec<i32>, k: i32) -> i32 {
        let mut nums = nums;
        nums.sort();
        let mut k = k;
        for i in 0..nums.len() {
            if nums[i] < 0 && k > 0 {
                nums[i] = -nums[i];
                k -= 1;
            }
        }
        if k % 2 == 1 {
            nums.sort();
            nums[0] = -nums[0];
        }
        nums.iter().sum()
    }
}