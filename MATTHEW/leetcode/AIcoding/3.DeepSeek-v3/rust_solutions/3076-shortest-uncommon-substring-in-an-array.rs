use std::collections::HashMap;

impl Solution {
    pub fn shortest_uncommon_substring(arr: Vec<String>) -> Vec<String> {
        let n = arr.len();
        let mut substrings: Vec<HashMap<String, bool>> = vec![HashMap::new(); n];
        let mut global_substrings: HashMap<String, Vec<usize>> = HashMap::new();

        for (i, s) in arr.iter().enumerate() {
            let len = s.len();
            for l in 1..=len {
                for start in 0..=len - l {
                    let substr = s[start..start + l].to_string();
                    substrings[i].insert(substr.clone(), true);
                    global_substrings.entry(substr).or_default().push(i);
                }
            }
        }

        let mut result = Vec::new();
        for (i, s) in arr.iter().enumerate() {
            let mut found = false;
            let mut shortest = String::new();
            for l in 1..=s.len() {
                for start in 0..=s.len() - l {
                    let substr = s[start..start + l].to_string();
                    if let Some(indices) = global_substrings.get(&substr) {
                        if indices.len() == 1 && indices[0] == i {
                            if !found || substr.len() < shortest.len() {
                                shortest = substr.clone();
                                found = true;
                            }
                        }
                    }
                }
                if found {
                    break;
                }
            }
            if found {
                result.push(shortest);
            } else {
                result.push("".to_string());
            }
        }

        result
    }
}