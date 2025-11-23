struct Solution;

impl Solution {
    pub fn max_consecutive_answers(s: String, k: i32) -> i32 {
        let mut max_count = 0;
        let mut left = 0;
        let mut count = std::collections::HashMap::new();

        for (right, c) in s.chars().enumerate() {
            *count.entry(c).or_insert(0) += 1;

            while *count.values().max().unwrap() > k {
                let left_char = s.chars().nth(left).unwrap();
                *count.get_mut(&left_char).unwrap() -= 1;
                if *count.get_mut(&left_char).unwrap() == 0 {
                    count.remove(&left_char);
                }
                left += 1;
            }

            max_count = std::cmp::max(max_count, right as i32 - left + 1);
        }

        max_count
    }
}