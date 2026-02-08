impl Solution {
    pub fn min_swaps(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let ones = nums.iter().filter(|&x| *x == 1).count();
        let mut window_ones = 0;
        for i in 0..ones {
            if nums[i] == 1 {
                window_ones += 1;
            }
        }
        let mut max_ones = window_ones;
        for i in ones..n {
            if nums[i] == 1 {
                window_ones += 1;
            }
            if nums[i - ones] == 1 {
                window_ones -= 1;
            }
            max_ones = max_ones.max(window_ones);
        }
        (ones as i32) - (max_ones as i32)
    }
}