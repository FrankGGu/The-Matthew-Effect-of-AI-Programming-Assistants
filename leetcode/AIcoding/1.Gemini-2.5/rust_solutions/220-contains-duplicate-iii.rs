use std::collections::BTreeSet;

impl Solution {
    pub fn contains_nearby_almost_duplicate(nums: Vec<i32>, k: i32, t: i32) -> bool {
        let k_usize = k as usize;
        let t_long = t as i64;

        let mut window_elements: BTreeSet<i64> = BTreeSet::new();

        for i in 0..nums.len() {
            let num_long = nums[i] as i64;

            let lower_bound = num_long - t_long;
            let upper_bound = num_long + t_long;

            if window_elements.range(lower_bound..=upper_bound).next().is_some() {
                return true;
            }

            window_elements.insert(num_long);

            if i >= k_usize {
                window_elements.remove(&(nums[i - k_usize] as i64));
            }
        }

        false
    }
}