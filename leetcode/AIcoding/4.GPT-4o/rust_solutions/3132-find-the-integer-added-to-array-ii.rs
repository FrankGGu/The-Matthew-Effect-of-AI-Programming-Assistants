pub fn find_integer(nums: Vec<i32>, m: i32) -> i32 {
    let mut sum = 0;
    let n = nums.len();
    for &num in &nums {
        sum += num;
    }
    let target = (m + sum) / (n as i32 + 1);
    if (m + sum) % (n as i32 + 1) == 0 && target <= m {
        return target;
    }
    m
}