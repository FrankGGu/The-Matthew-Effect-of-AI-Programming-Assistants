impl Solution {
    pub fn maximum_gap(nums: Vec<i32>) -> i32 {
        if nums.len() < 2 {
            return 0;
        }

        let min_val = *nums.iter().min().unwrap();
        let max_val = *nums.iter().max().unwrap();

        let bucket_size = std::cmp::max(1, (max_val - min_val) as usize / (nums.len() - 1));
        let bucket_count = ((max_val - min_val) as usize / bucket_size) + 1;

        let mut buckets = vec![(None, None); bucket_count];

        for num in nums {
            let idx = ((num - min_val) as usize / bucket_size);
            let bucket = &mut buckets[idx];
            match bucket {
                &mut (Some(min), Some(max)) => {
                    if num < min {
                        *bucket = (Some(num), Some(max));
                    } else if num > max {
                        *bucket = (Some(min), Some(num));
                    }
                },
                _ => *bucket = (Some(num), Some(num)),
            }
        }

        let mut max_gap = 0;
        let mut prev_max = min_val;

        for bucket in buckets {
            if let (Some(current_min), Some(current_max)) = bucket {
                max_gap = std::cmp::max(max_gap, current_min - prev_max);
                prev_max = current_max;
            }
        }

        max_gap
    }
}