pub fn maximize_sum(nums: Vec<i32>, k: i32) -> i32 {
    let mut nums = nums;
    nums.sort_unstable();
    let n = nums.len() as i32;
    let mut total_sum = 0;
    for i in 0..k {
        total_sum += nums[n as usize - 1] + i;
    }
    total_sum
}