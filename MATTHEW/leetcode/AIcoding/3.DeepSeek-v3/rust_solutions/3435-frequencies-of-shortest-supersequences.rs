use std::collections::HashMap;

impl Solution {
    pub fn shortest_supersequence_frequencies(arr: Vec<i32>) -> Vec<i32> {
        let mut freq = HashMap::new();
        let mut pos = HashMap::new();
        let mut result = vec![0; arr.len()];

        for (i, &num) in arr.iter().enumerate() {
            let entry = freq.entry(num).or_insert(0);
            *entry += 1;
            pos.insert(num, i);

            if *entry == 1 {
                result[i] = -1;
            } else {
                let mut min_len = i32::MAX;
                for (&k, &v) in freq.iter() {
                    if v == 1 {
                        let p = pos[&k];
                        let len = (i - p + 1) as i32;
                        if len < min_len {
                            min_len = len;
                        }
                    }
                }
                result[i] = if min_len != i32::MAX { min_len } else { -1 };
            }
        }

        result
    }
}