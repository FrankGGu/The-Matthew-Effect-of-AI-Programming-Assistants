pub fn count_monotonic_pairs(nums: Vec<i32>) -> i64 {
    let n = nums.len();
    let mut count = 0;
    let mut increasing = vec![1; n];
    let mut decreasing = vec![1; n];

    for i in 1..n {
        if nums[i] >= nums[i - 1] {
            increasing[i] = increasing[i - 1] + 1;
        }
        if nums[i] <= nums[i - 1] {
            decreasing[i] = decreasing[i - 1] + 1;
        }
    }

    for i in 0..n {
        count += increasing[i] as i64;
        count += decreasing[i] as i64;
    }

    count - n as i64
}