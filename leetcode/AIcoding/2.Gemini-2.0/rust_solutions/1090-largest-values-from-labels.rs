impl Solution {
    pub fn largest_values_from_labels(values: Vec<i32>, labels: Vec<i32>, num_wanted: i32, use_limit: i32) -> i32 {
        let n = values.len();
        let mut pairs: Vec<(i32, i32)> = Vec::with_capacity(n);
        for i in 0..n {
            pairs.push((values[i], labels[i]));
        }

        pairs.sort_by(|a, b| b.0.cmp(&a.0));

        let mut ans = 0;
        let mut count = 0;
        let mut used_labels: std::collections::HashMap<i32, i32> = std::collections::HashMap::new();

        for (value, label) in pairs {
            if count == num_wanted {
                break;
            }

            let used_count = used_labels.entry(label).or_insert(0);
            if *used_count < use_limit {
                ans += value;
                *used_count += 1;
                count += 1;
            }
        }

        ans
    }
}