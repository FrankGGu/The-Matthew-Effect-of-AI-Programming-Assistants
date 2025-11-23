pub fn min_moves_to_pick_k_ones(nums: Vec<i32>, k: i32) -> i32 {
    let n = nums.len();
    let mut ones = vec![0; n + 1];
    for i in 0..n {
        ones[i + 1] = ones[i] + nums[i] as i32;
    }
    let mut res = i32::MAX;
    for i in 0..=n - k as usize {
        let moves = k * (i as i32) - (ones[i + k as usize] - ones[i]);
        res = res.min(moves);
    }
    res
}