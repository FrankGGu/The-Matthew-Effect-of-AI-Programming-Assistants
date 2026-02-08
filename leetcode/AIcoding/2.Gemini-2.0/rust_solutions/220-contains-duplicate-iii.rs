use std::collections::BTreeMap;

impl Solution {
    pub fn contains_nearby_almost_duplicate(nums: Vec<i32>, k: i32, t: i32) -> bool {
        let k = k as usize;
        let t = t as i64;

        let mut window: BTreeMap<i64, i32> = BTreeMap::new();

        for i in 0..nums.len() {
            let num = nums[i] as i64;

            let lower_bound = num - t;
            let upper_bound = num + t;

            let sub_view = window.range(lower_bound..=upper_bound);

            if sub_view.next().is_some() {
                return true;
            }

            *window.entry(num).or_insert(0) += 1;

            if i >= k {
                let num_to_remove = nums[i - k] as i64;
                *window.get_mut(&num_to_remove).unwrap() -= 1;
                if window[&num_to_remove] == 0 {
                    window.remove(&num_to_remove);
                }
            }
        }

        false
    }
}