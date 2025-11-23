use std::collections::HashMap;

impl Solution {
    pub fn contains_nearby_almost_duplicate(nums: Vec<i32>, k: i32, t: i32) -> bool {
        let mut buckets: HashMap<i64, i64> = HashMap::new();
        let w = t as i64 + 1;

        for i in 0..nums.len() {
            let num = nums[i] as i64;
            let bucket_id = num / w;

            if buckets.contains_key(&bucket_id) {
                return true;
            }

            if let Some(&v) = buckets.get(&(bucket_id - 1)) {
                if num - v <= t as i64 {
                    return true;
                }
            }

            if let Some(&v) = buckets.get(&(bucket_id + 1)) {
                if v - num <= t as i64 {
                    return true;
                }
            }

            buckets.insert(bucket_id, num);

            if i >= k as usize {
                let remove_bucket_id = (nums[i - k as usize] as i64) / w;
                buckets.remove(&remove_bucket_id);
            }
        }
        false
    }
}