impl Solution {
    pub fn maximum_gap(nums: Vec<i32>) -> i32 {
        if nums.len() < 2 {
            return 0;
        }
        let min_num = *nums.iter().min().unwrap();
        let max_num = *nums.iter().max().unwrap();
        let bucket_size = (max_num - min_num) as usize / (nums.len() - 1).max(1) + 1;
        let bucket_count = (max_num - min_num) as usize / bucket_size + 1;

        let mut buckets: Vec<(Option<i32>, Option<i32>)> = vec![None; bucket_count];
        for &num in &nums {
            let idx = (num - min_num) as usize / bucket_size;
            let bucket = &mut buckets[idx];
            bucket.0 = Some(bucket.0.unwrap_or(num));
            bucket.1 = Some(bucket.1.unwrap_or(num));
        }

        let mut max_gap = 0;
        let mut prev_max = min_num;

        for bucket in buckets {
            if let (Some(min), Some(max)) = bucket {
                max_gap = max_gap.max(min - prev_max);
                prev_max = max;
            }
        }

        max_gap
    }
}