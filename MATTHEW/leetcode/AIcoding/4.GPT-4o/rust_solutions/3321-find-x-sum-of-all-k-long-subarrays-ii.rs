pub fn x_sum(nums: Vec<i32>, k: i32) -> i32 {
    let n = nums.len();
    let k = k as usize;
    let mut sum = 0;
    let mut prefix = vec![0; n + 1];

    for i in 0..n {
        prefix[i + 1] = prefix[i] + nums[i];
    }

    for i in 0..=n - k {
        sum += prefix[i + k] - prefix[i];
    }

    sum
}