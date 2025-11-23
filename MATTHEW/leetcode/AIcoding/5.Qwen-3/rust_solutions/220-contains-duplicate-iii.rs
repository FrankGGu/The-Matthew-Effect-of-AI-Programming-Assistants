impl Solution {

use std::collections::BTreeSet;

impl Solution {
    pub fn contains_nearby_almost_duplicate(nums: Vec<i32>, k: i32, t: i32) -> bool {
        let mut window = BTreeSet::new();
        for (i, &num) in nums.iter().enumerate() {
            if i > k as usize {
                window.remove(&nums[i - k as usize - 1]);
            }
            let bucket = num / (t + 1);
            if window.contains(&bucket) {
                return true;
            }
            if let Some(prev) = window.range(..bucket).next_back() {
                if (num - prev) <= t {
                    return true;
                }
            }
            if let Some(next) = window.range(bucket..).next() {
                if (next - num) <= t {
                    return true;
                }
            }
            window.insert(bucket);
        }
        false
    }
}
}