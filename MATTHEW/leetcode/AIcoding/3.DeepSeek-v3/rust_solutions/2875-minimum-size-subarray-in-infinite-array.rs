impl Solution {
    pub fn min_size_subarray(nums: Vec<i32>, target: i32) -> i32 {
        let total: i32 = nums.iter().sum();
        let n = nums.len();
        let k = (target / total) as usize;
        let remaining = target - k as i32 * total;

        if remaining == 0 {
            return (k * n) as i32;
        }

        let mut min_len = usize::MAX;
        let mut prefix = vec![0; n * 2 + 1];
        for i in 0..n * 2 {
            prefix[i + 1] = prefix[i] + nums[i % n];
        }

        let mut left = 0;
        for right in 0..prefix.len() {
            while prefix[right] - prefix[left] > remaining {
                left += 1;
            }
            if prefix[right] - prefix[left] == remaining {
                min_len = min_len.min(right - left);
            }
        }

        if min_len == usize::MAX {
            -1
        } else {
            (k * n + min_len) as i32
        }
    }
}