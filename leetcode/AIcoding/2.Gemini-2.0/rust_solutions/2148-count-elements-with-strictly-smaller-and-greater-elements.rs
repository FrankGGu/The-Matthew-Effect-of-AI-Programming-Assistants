impl Solution {
    pub fn count_elements(nums: Vec<i32>) -> i32 {
        if nums.len() <= 2 {
            return 0;
        }

        let mut min_val = nums[0];
        let mut max_val = nums[0];

        for &num in &nums {
            min_val = min_val.min(num);
            max_val = max_val.max(num);
        }

        let mut count = 0;
        for &num in &nums {
            if num > min_val && num < max_val {
                count += 1;
            }
        }

        count
    }
}