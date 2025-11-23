struct Solution;

impl Solution {
    pub fn num_good_ways(s: String) -> i32 {
        let mut left_counts = std::collections::HashMap::new();
        let mut right_counts = std::collections::HashMap::new();
        let mut left_unique = 0;
        let mut right_unique = 0;

        for c in s.chars() {
            *right_counts.entry(c).or_insert(0) += 1;
        }

        let mut result = 0;

        for c in s.chars() {
            *right_counts.entry(c).or_insert(0) -= 1;
            if right_counts[&c] == 0 {
                right_counts.remove(&c);
            }

            if !left_counts.contains_key(&c) {
                left_unique += 1;
                left_counts.insert(c, 1);
            } else {
                left_counts.entry(c).and_modify(|e| *e += 1);
            }

            if left_unique == right_counts.len() {
                result += 1;
            }
        }

        result
    }
}