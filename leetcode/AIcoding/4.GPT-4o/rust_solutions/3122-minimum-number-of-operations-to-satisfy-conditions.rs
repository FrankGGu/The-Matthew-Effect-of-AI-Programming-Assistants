pub fn min_operations(nums: Vec<i32>, x: i32) -> i32 {
    let target = nums.iter().sum::<i32>() - x;
    if target < 0 {
        return -1;
    }

    let mut max_len = 0;
    let mut current_sum = 0;
    let mut left = 0;

    for right in 0..nums.len() {
        current_sum += nums[right];

        while current_sum > target {
            current_sum -= nums[left];
            left += 1;
        }

        if current_sum == target {
            max_len = max_len.max(right - left + 1);
        }
    }

    if max_len == 0 {
        return -1;
    }

    (nums.len() - max_len) as i32
}