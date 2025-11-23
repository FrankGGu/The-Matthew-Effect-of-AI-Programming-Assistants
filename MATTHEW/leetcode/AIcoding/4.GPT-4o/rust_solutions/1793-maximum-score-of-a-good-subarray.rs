pub fn maximum_score(nums: Vec<i32>, k: usize) -> i32 {
    let n = nums.len();
    let mut max_score = 0;
    let mut left = k;
    let mut right = k;

    while left > 0 || right < n - 1 {
        if left == 0 {
            right += 1;
        } else if right == n - 1 {
            left -= 1;
        } else if nums[left - 1] >= nums[right + 1] {
            left -= 1;
        } else {
            right += 1;
        }
        max_score = max_score.max(nums[left..=right].iter().min().unwrap() * (right - left + 1) as i32);
    }

    max_score
}