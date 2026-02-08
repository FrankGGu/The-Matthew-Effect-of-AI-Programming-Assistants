use std::collections::HashMap;

impl Solution {
    pub fn make_xor_equal_zero(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let k = k as usize;
        let mut ans = 0;
        for i in 0..k {
            let mut cnt = HashMap::new();
            let mut total = 0;
            for j in (i..n).step_by(k) {
                *cnt.entry(nums[j]).or_insert(0) += 1;
                total += 1;
            }
            let mut max_freq = 0;
            for (_, &freq) in cnt.iter() {
                max_freq = max_freq.max(freq);
            }
            ans += total - max_freq;
        }
        ans as i32
    }
}