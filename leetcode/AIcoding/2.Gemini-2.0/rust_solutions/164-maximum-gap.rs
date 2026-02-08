impl Solution {
    pub fn maximum_gap(nums: Vec<i32>) -> i32 {
        if nums.len() < 2 {
            return 0;
        }

        let min_val = *nums.iter().min().unwrap();
        let max_val = *nums.iter().max().unwrap();
        let n = nums.len();

        if min_val == max_val {
            return 0;
        }

        let bucket_size = ((max_val - min_val) as f64 / (n - 1) as f64).ceil() as i32;

        let bucket_count = ((max_val - min_val) as f64 / bucket_size as f64).ceil() as usize;

        let mut buckets_min = vec![i32::max_value(); bucket_count];
        let mut buckets_max = vec![i32::min_value(); bucket_count];

        for &num in &nums {
            let bucket_index = ((num - min_val) / bucket_size) as usize;
            buckets_min[bucket_index] = buckets_min[bucket_index].min(num);
            buckets_max[bucket_index] = buckets_max[bucket_index].max(num);
        }

        let mut max_gap = 0;
        let mut prev_max = buckets_max[0];

        for i in 1..bucket_count {
            if buckets_min[i] == i32::max_value() {
                continue;
            }
            max_gap = max_gap.max(buckets_min[i] - prev_max);
            prev_max = buckets_max[i];
        }

        max_gap
    }
}