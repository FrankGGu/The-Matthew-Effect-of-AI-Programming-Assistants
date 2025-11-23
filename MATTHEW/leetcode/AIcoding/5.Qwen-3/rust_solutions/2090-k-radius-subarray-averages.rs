pub fn results_array(nums: Vec<i32>, k: i32) -> Vec<i32> {
    let n = nums.len();
    let k = k as usize;
    let mut result = vec![0; n];

    for i in 0..n {
        let left = i.saturating_sub(k);
        let right = i + k;
        if right >= n {
            continue;
        }
        let mut avg = 0;
        for j in left..=right {
            avg += nums[j];
        }
        result[i] = avg / ((2 * k + 1) as i32);
    }

    result
}