impl Solution {
    pub fn minimum_index(s: String) -> i32 {
        let n = s.len();
        let mut count = std::collections::HashMap::new();
        for c in s.chars() {
            *count.entry(c).or_insert(0) += 1;
        }

        let mut prefix_count = std::collections::HashMap::new();
        let mut total_count = count.clone();
        let mut max_freq = 0;
        let mut total_chars = 0;

        for (i, c) in s.chars().enumerate() {
            *prefix_count.entry(c).or_insert(0) += 1;
            *total_count.get_mut(&c).unwrap() -= 1;

            total_chars += 1;
            if prefix_count[&c] > max_freq {
                max_freq = prefix_count[&c];
            }

            if max_freq > (total_chars as f64 / 2.0) {
                continue;
            }

            let mut valid = true;
            let mut suffix_max_freq = 0;
            for (&k, &v) in &total_count {
                if v > 0 {
                    if v > suffix_max_freq {
                        suffix_max_freq = v;
                    }
                }
            }

            if suffix_max_freq > (n - total_chars) as f64 / 2.0 {
                valid = false;
            }

            if valid {
                return i as i32;
            }
        }

        -1
    }
}