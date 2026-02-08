impl Solution {
    pub fn find_non_min_or_max(nums: Vec<i32>) -> i32 {
        if nums.len() <= 2 {
            return -1;
        }
        let min_val = *nums.iter().min().unwrap();
        let max_val = *nums.iter().max().unwrap();
        for &num in &nums {
            if num != min_val && num != max_val {
                return num;
            }
        }
        -1
    }
}