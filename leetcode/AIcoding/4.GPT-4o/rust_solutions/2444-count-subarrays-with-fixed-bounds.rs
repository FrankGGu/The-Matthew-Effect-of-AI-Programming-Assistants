pub fn count_subarrays(nums: Vec<i32>, min_k: i32, max_k: i32) -> i64 {
    let mut count = 0;
    let mut start = 0;
    let mut last_min = -1;
    let mut last_max = -1;

    for i in 0..nums.len() {
        if nums[i] < min_k || nums[i] > max_k {
            start = i + 1;
            last_min = -1;
            last_max = -1;
        } else {
            if nums[i] == min_k {
                last_min = i as i64;
            }
            if nums[i] == max_k {
                last_max = i as i64;
            }
            count += (last_min.max(last_max) - start as i64 + 1).max(0);
        }
    }
    count
}