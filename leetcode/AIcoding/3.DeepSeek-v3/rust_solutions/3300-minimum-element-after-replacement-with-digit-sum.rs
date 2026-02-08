impl Solution {
    pub fn min_element_after_replacement(nums: Vec<i32>, k: i32) -> i32 {
        let mut nums = nums;
        for _ in 0..k {
            let mut min_idx = 0;
            for i in 1..nums.len() {
                if nums[i] < nums[min_idx] {
                    min_idx = i;
                }
            }
            let sum = nums[min_idx].to_string().chars().map(|c| c.to_digit(10).unwrap() as i32).sum();
            nums[min_idx] = sum;
        }
        *nums.iter().min().unwrap()
    }
}