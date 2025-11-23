use std::collections::BTreeSet;

impl Solution {
    pub fn contains_nearby_almost_duplicate(nums: Vec<i32>, k: i32, t: i32) -> bool {
        let k = k as usize;
        let t = t as i64;
        let mut set = BTreeSet::new();

        for i in 0..nums.len() {
            let num = nums[i] as i64;
            if let Some(&x) = set.range(num - t..=num + t).next() {
                if (x - num).abs() <= t {
                    return true;
                }
            }
            set.insert(num);
            if i >= k {
                set.remove(&(nums[i - k] as i64));
            }
        }
        false
    }
}