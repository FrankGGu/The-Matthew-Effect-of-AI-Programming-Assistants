use std::collections::HashMap;

impl Solution {
    pub fn contains_nearby_almost_duplicate(nums: Vec<i32>, index_diff: i32, value_diff: i32) -> bool {
        if index_diff <= 0 || value_diff < 0 {
            return false;
        }
        let mut buckets: HashMap<i64, i64> = HashMap::new();
        let w = value_diff as i64 + 1;

        for i in 0..nums.len() {
            let num = nums[i] as i64;
            let bucket_key = num / w;

            if buckets.contains_key(&bucket_key) {
                return true;
            }
            if let Some(&v) = buckets.get(&(bucket_key - 1)) {
                if num - v <= value_diff as i64 {
                    return true;
                }
            }
            if let Some(&v) = buckets.get(&(bucket_key + 1)) {
                if v - num <= value_diff as i64 {
                    return true;
                }
            }

            buckets.insert(bucket_key, num);
            if i >= index_diff as usize {
                let old_key = nums[i - index_diff as usize] as i64 / w;
                buckets.remove(&old_key);
            }
        }
        false
    }
}