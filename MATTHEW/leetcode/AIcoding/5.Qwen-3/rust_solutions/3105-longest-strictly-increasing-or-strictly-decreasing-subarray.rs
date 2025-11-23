pub fn longest_strict_monotonic_subarray(nums: Vec<i32>) -> i32 {
    if nums.len() < 2 {
        return nums.len() as i32;
    }

    let mut max_len = 1;
    let mut current_len = 1;

    for i in 1..nums.len() {
        if nums[i] > nums[i - 1] {
            current_len += 1;
        } else if nums[i] < nums[i - 1] {
            current_len = 1;
        } else {
            current_len = 1;
        }
        max_len = std::cmp::max(max_len, current_len);
    }

    for i in 1..nums.len() {
        if nums[i] < nums[i - 1] {
            current_len += 1;
        } else if nums[i] > nums[i - 1] {
            current_len = 1;
        } else {
            current_len = 1;
        }
        max_len = std::cmp::max(max_len, current_len);
    }

    max_len
}