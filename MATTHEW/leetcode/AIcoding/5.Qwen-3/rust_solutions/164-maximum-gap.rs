impl Solution {
    pub fn maximum_gap(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        if n < 2 {
            return 0;
        }

        let min_val = *nums.iter().min().unwrap();
        let max_val = *nums.iter().max().unwrap();

        if min_val == max_val {
            return 0;
        }

        let mut buckets = vec![None; n - 1];
        let bucket_size = (max_val - min_val) as f64 / (n as f64 - 1.0);

        for &num in &nums {
            if num == max_val {
                continue;
            }
            let idx = ((num - min_val) as f64 / bucket_size).floor() as usize;
            match buckets[idx] {
                None => {
                    buckets[idx] = Some((num, num));
                }
                Some((low, high)) => {
                    buckets[idx] = Some((std::cmp::min(low, num), std::cmp::max(high, num)));
                }
            }
        }

        let mut max_gap = 0;
        let mut prev = min_val;

        for bucket in buckets {
            if let Some((low, _)) = bucket {
                max_gap = std::cmp::max(max_gap, low - prev);
                prev = low;
            }
        }

        max_gap
    }
}