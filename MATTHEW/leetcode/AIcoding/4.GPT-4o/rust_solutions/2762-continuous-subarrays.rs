pub fn continuous_subarrays(nums: Vec<i32>) -> i32 {
    let mut left = 0;
    let mut count = 0;
    let mut min_val = nums[0];
    let mut max_val = nums[0];

    for right in 0..nums.len() {
        min_val = min_val.min(nums[right]);
        max_val = max_val.max(nums[right]);

        while max_val - min_val > 2 {
            left += 1;
            min_val = *nums[left..=right].iter().min().unwrap();
            max_val = *nums[left..=right].iter().max().unwrap();
        }
        count += right - left + 1;
    }
    count
}