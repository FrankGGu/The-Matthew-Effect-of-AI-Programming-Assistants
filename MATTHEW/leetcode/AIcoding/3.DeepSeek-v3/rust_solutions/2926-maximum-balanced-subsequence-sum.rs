use std::collections::BTreeMap;

impl Solution {
    pub fn max_balanced_subsequence_sum(nums: Vec<i32>) -> i64 {
        let mut map: BTreeMap<i32, i64> = BTreeMap::new();
        let mut max_sum = std::i64::MIN;

        for (i, &num) in nums.iter().enumerate() {
            let key = num - i as i32;
            let mut current_max = num as i64;

            if let Some((_, &sum)) = map.range(..=key).last() {
                current_max += sum;
            }

            while let Some((&k, &v)) = map.range(key..).next() {
                if v <= current_max {
                    map.remove(&k);
                } else {
                    break;
                }
            }

            if map.range(..=key).last().map_or(true, |(_, &s)| s < current_max) {
                map.insert(key, current_max);
                if current_max > max_sum {
                    max_sum = current_max;
                }
            }
        }

        max_sum
    }
}