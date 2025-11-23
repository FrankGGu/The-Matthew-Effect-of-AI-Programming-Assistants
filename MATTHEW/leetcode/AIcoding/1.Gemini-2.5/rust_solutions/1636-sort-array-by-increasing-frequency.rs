use std::collections::HashMap;

impl Solution {
    pub fn frequency_sort(mut nums: Vec<i32>) -> Vec<i32> {
        let mut freq_map: HashMap<i32, i32> = HashMap::new();
        for &num in &nums {
            *freq_map.entry(num).or_insert(0) += 1;
        }

        nums.sort_by(|&a, &b| {
            let freq_a = freq_map.get(&a).unwrap();
            let freq_b = freq_map.get(&b).unwrap();

            if freq_a != freq_b {
                freq_a.cmp(freq_b)
            } else {
                b.cmp(&a)
            }
        });

        nums
    }
}