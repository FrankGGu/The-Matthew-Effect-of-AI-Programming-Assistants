impl Solution {
    pub fn find_non_min_or_max(nums: Vec<i32>) -> i32 {
        if nums.len() < 3 {
            return -1;
        }

        let mut min_val = i32::MAX;
        let mut max_val = i32::MIN;

        for &num in &nums {
            min_val = min_val.min(num);
            max_val = max_val.max(num);
        }

        for &num in &nums {
            if num != min_val && num != max_val {
                return num;
            }
        }

        -1
    }
}