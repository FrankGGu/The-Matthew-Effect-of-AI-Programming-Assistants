pub fn longest_nice_subarray(nums: Vec<i32>) -> i32 {
    let mut seen = 0;
    let mut left = 0;
    let mut max_length = 0;

    for right in 0..nums.len() {
        while (seen & nums[right]) != 0 {
            seen ^= nums[left];
            left += 1;
        }
        seen |= nums[right];
        max_length = max_length.max(right - left + 1);
    }

    max_length
}