pub fn count_monotonic_pairs(nums: Vec<i32>) -> i32 {
    let n = nums.len();
    let mut count = 0;
    let mut increasing = 0;
    let mut decreasing = 0;

    for i in 1..n {
        if nums[i] >= nums[i - 1] {
            increasing += 1;
            count += increasing;
        } else {
            increasing = 0;
        }

        if nums[i] <= nums[i - 1] {
            decreasing += 1;
            count += decreasing;
        } else {
            decreasing = 0;
        }
    }

    count as i32
}