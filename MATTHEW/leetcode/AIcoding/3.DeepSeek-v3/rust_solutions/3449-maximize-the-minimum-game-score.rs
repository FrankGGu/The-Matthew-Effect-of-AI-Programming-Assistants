impl Solution {
    pub fn maximize_min(nums: Vec<i32>, k: i32) -> i32 {
        let mut left = *nums.iter().min().unwrap();
        let mut right = *nums.iter().max().unwrap();
        let k = k as usize;
        let n = nums.len();

        while left < right {
            let mid = left + (right - left + 1) / 2;
            let mut count = 0;
            let mut i = 0;

            while i < n {
                if nums[i] >= mid {
                    count += 1;
                    i += k;
                } else {
                    i += 1;
                }
            }

            if count >= (n + k - 1) / k {
                left = mid;
            } else {
                right = mid - 1;
            }
        }

        left
    }
}