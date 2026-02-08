use std::collections::HashMap;

impl Solution {
    pub fn min_substring_partition(s: String) -> i32 {
        let n = s.len();
        let chars: Vec<char> = s.chars().collect();
        let mut ans = n as i32;

        for i in 0..(1 << (n - 1)) {
            let mut partitions = Vec::new();
            let mut current_partition = String::new();
            current_partition.push(chars[0]);
            for j in 0..(n - 1) {
                if (i >> j) & 1 == 1 {
                    partitions.push(current_partition.clone());
                    current_partition.clear();
                }
                current_partition.push(chars[j + 1]);
            }
            partitions.push(current_partition.clone());

            let mut valid = true;
            for partition in &partitions {
                let mut counts: HashMap<char, i32> = HashMap::new();
                for c in partition.chars() {
                    *counts.entry(c).or_insert(0) += 1;
                }
                if counts.is_empty() {
                    continue;
                }
                let first_count = *counts.values().next().unwrap();
                for count in counts.values() {
                    if *count != first_count {
                        valid = false;
                        break;
                    }
                }
                if !valid {
                    break;
                }
            }

            if valid {
                ans = ans.min(partitions.len() as i32);
            }
        }

        ans
    }
}