pub fn max_width_ramp(nums: Vec<i32>) -> i32 {
    let mut max_width = 0;
    let mut stack = Vec::new();

    for i in 0..nums.len() {
        if stack.is_empty() || nums[*stack.last().unwrap()] > nums[i] {
            stack.push(i);
        }
    }

    for j in (0..nums.len()).rev() {
        while let Some(&i) = stack.last() {
            if nums[i] <= nums[j] {
                max_width = max_width.max(j - i);
                stack.pop();
            } else {
                break;
            }
        }
    }

    max_width
}