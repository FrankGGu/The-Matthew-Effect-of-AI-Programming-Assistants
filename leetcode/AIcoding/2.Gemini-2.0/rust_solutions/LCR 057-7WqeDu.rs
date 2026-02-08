use std::collections::BTreeMap;

impl Solution {
    pub fn contains_nearby_almost_duplicate(nums: Vec<i32>, k: i32, t: i32) -> bool {
        let mut map = BTreeMap::new();
        for i in 0..nums.len() {
            let num = nums[i] as i64;
            let lower_bound = num - t as i64;
            let upper_bound = num + t as i64;

            let sub_map = map.range(lower_bound..=upper_bound);
            if sub_map.next().is_some() {
                return true;
            }

            map.insert(num, i);
            if map.len() > k as usize {
                map.remove(&(nums[i - k as usize] as i64));
            }
        }
        false
    }
}