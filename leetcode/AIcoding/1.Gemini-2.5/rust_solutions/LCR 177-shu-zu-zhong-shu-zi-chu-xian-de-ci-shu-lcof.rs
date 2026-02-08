use std::collections::HashMap;

impl Solution {
    pub fn count_contrasting_pairs(colors: Vec<i32>, target: i32) -> i32 {
        let mut count = 0;
        let mut freq_map: HashMap<i32, i32> = HashMap::new();

        for &color in colors.iter() {
            if target == 0 {
                if let Some(&c) = freq_map.get(&color) {
                    count += c;
                }
            } else {
                if let Some(&c) = freq_map.get(&(color - target)) {
                    count += c;
                }
                if let Some(&c) = freq_map.get(&(color + target)) {
                    count += c;
                }
            }
            *freq_map.entry(color).or_insert(0) += 1;
        }

        count
    }
}