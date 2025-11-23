pub fn max_score(nums: Vec<i32>, k: i32) -> i32 {
    let n = nums.len();
    let k = k as usize;
    let mut total_sum: i32 = nums.iter().sum();
    let mut min_sum: i32 = nums[..n - k].iter().sum();
    let mut max_score = total_sum - min_sum;

    for i in n - k..n {
        min_sum += nums[i];
        if i >= n - k {
            min_sum -= nums[i - (n - k)];
        }
        max_score = max_score.max(total_sum - min_sum);
    }

    max_score
}