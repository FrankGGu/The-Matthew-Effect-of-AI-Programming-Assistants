use std::collections::HashMap;

impl Solution {
    pub fn three_sum_multi(arr: Vec<i32>, target: i32) -> i32 {
        let mut count = 0;
        let mut freq = HashMap::new();

        for &num in &arr {
            *freq.entry(num).or_insert(0) += 1;
        }

        let keys: Vec<i32> = freq.keys().cloned().collect();
        let n = keys.len();

        for i in 0..n {
            for j in i..n {
                let k = target - keys[i] - keys[j];
                if let Some(&c) = freq.get(&k) {
                    if i == j && keys[i] == k {
                        count += c * (c - 1) * (c - 2) / 6;
                    } else if i == j {
                        count += c * (c - 1) / 2 * freq[&keys[i]];
                    } else if j < n && keys[j] == k {
                        count += c * freq[&keys[i]];
                    } else if j < n {
                        count += freq[&keys[i]] * freq[&keys[j]] * c;
                    }
                }
            }
        }

        (count % 1_000_000_007) as i32
    }
}