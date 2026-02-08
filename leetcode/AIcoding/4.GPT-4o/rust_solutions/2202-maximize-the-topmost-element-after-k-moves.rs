pub fn maximize_the_top(nums: Vec<i32>, k: i32) -> i32 {
    let n = nums.len();
    if k == 0 {
        return if n > 0 { nums[0] } else { -1 };
    }
    let mut max_top = -1;
    for i in 0..std::cmp::min(n as i32, k + 1) {
        max_top = max_top.max(nums[i as usize]);
    }
    if k as usize >= n {
        max_top = max_top.max(0);
    }
    max_top
}