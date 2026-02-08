impl Solution {
    pub fn min_days(bloom_day: Vec<i32>, m: i32, k: i32) -> i32 {
        let n = bloom_day.len();
        if m * k > n { return -1; }

        let mut left = *bloom_day.iter().min().unwrap();
        let mut right = *bloom_day.iter().max().unwrap();

        while left < right {
            let mid = left + (right - left) / 2;
            let mut bouquets = 0;
            let mut flowers = 0;

            for &day in &bloom_day {
                if day <= mid {
                    flowers += 1;
                    if flowers == k {
                        bouquets += 1;
                        flowers = 0;
                    }
                } else {
                    flowers = 0;
                }
            }

            if bouquets >= m {
                right = mid;
            } else {
                left = mid + 1;
            }
        }

        left
    }
}