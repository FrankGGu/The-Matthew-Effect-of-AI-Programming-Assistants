impl Solution {
    pub fn ways_to_split(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut prefix_sums = vec![0; n + 1];
        for i in 0..n {
            prefix_sums[i + 1] = prefix_sums[i] + nums[i];
        }

        let mut count = 0;
        for i in 1..n - 1 {
            let mut left = i + 1;
            let mut right = n - 1;
            let mut lower_bound = n;
            while left <= right {
                let mid = left + (right - left) / 2;
                let first = prefix_sums[i];
                let second = prefix_sums[mid] - prefix_sums[i];
                if second >= first {
                    lower_bound = mid;
                    right = mid - 1;
                } else {
                    left = mid + 1;
                }
            }

            left = i + 1;
            right = n - 1;
            let mut upper_bound = i;
            while left <= right {
                let mid = left + (right - left) / 2;
                let first = prefix_sums[i];
                let second = prefix_sums[mid] - prefix_sums[i];
                let third = prefix_sums[n] - prefix_sums[mid];
                if second <= third {
                    upper_bound = mid;
                    left = mid + 1;
                } else {
                    right = mid - 1;
                }
            }

            if lower_bound <= upper_bound {
                count = (count + (upper_bound - lower_bound + 1) as i32) % 1000000007;
            }
        }

        count
    }
}