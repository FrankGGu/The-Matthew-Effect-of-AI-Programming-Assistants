impl Solution {
    pub fn min_k_bit_flips(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let k = k as usize;
        let mut flips = 0;
        let mut flip_count = vec![0; n];
        let mut current_flips = 0;

        for i in 0..n {
            current_flips += flip_count[i];

            if (nums[i] + current_flips) % 2 == 0 {
                if i + k > n {
                    return -1;
                }
                flips += 1;
                current_flips += 1;
                if i + k < n {
                    flip_count[i + k] -= 1;
                }
            }
        }

        flips
    }
}