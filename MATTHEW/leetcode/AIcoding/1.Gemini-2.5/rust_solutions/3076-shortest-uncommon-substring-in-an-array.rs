use std::collections::{HashMap, HashSet};

impl Solution {
    pub fn shortest_uncommon_substring(arr: Vec<String>) -> Vec<String> {
        let n = arr.len();
        let mut all_substring_indices: HashMap<String, HashSet<usize>> = HashMap::new();

        for i in 0..n {
            let s = &arr[i];
            for start in 0..s.len() {
                for end in (start + 1)..=s.len() {
                    let sub = s[start..end].to_string();
                    all_substring_indices.entry(sub).or_default().insert(i);
                }
            }
        }

        let mut result: Vec<String> = Vec::with_capacity(n);

        for i in 0..n {
            let s = &arr[i];
            let mut best_uncommon_sub = String::new();

            for length in 1..=s.len() {
                for start in 0..=(s.len() - length) {
                    let sub = &s[start..(start + length)];

                    if let Some(indices) = all_substring_indices.get(sub) {
                        if indices.len() == 1 && indices.contains(&i) {
                            if best_uncommon_sub.is_empty() {
                                best_uncommon_sub = sub.to_string();
                            } else if sub.len() < best_uncommon_sub.len() {
                                best_uncommon_sub = sub.to_string();
                            } else if sub.len() == best_uncommon_sub.len() {
                                if sub < best_uncommon_sub {
                                    best_uncommon_sub = sub.to_string();
                                }
                            }
                        }
                    }
                }
                if !best_uncommon_sub.is_empty() && best_uncommon_sub.len() == length {
                    break; 
                }
            }
            result.push(best_uncommon_sub);
        }

        result
    }
}