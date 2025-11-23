impl Solution {
    pub fn min_swaps(nums: Vec<i32>) -> i32 {
        let ones = nums.iter().filter(|&&x| x == 1).count();
        let n = nums.len();
        if ones == 0 || ones == n {
            return 0;
        }
        let mut window_ones = 0;
        for i in 0..ones {
            if nums[i] == 1 {
                window_ones += 1;
            }
        }
        let mut max_ones = window_ones;
        for i in 1..n {
            let left = i - 1;
            let right = (i + ones - 1) % n;
            if nums[left] == 1 {
                window_ones -= 1;
            }
            if nums[right] == 1 {
                window_ones += 1;
            }
            if window_ones > max_ones {
                max_ones = window_ones;
            }
        }
        (ones - max_ones) as i32
    }
}