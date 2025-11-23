use std::collections::HashMap;
use std::collections::BTreeMap;

struct Solution;

impl Solution {
    pub fn most_frequent_ids(ids: Vec<i32>, freqs: Vec<i32>) -> Vec<i64> {
        let mut id_counts: HashMap<i32, i64> = HashMap::new();
        let mut freq_counts: BTreeMap<i64, i32> = BTreeMap::new();
        let mut result: Vec<i64> = Vec::with_capacity(ids.len());

        for i in 0..ids.len() {
            let id = ids[i];
            let delta_freq = freqs[i] as i64;

            let old_freq = *id_counts.get(&id).unwrap_or(&0);
            let new_freq = old_freq + delta_freq;

            id_counts.insert(id, new_freq);

            if old_freq > 0 {
                if let Some(count) = freq_counts.get_mut(&old_freq) {
                    *count -= 1;
                    if *count == 0 {
                        freq_counts.remove(&old_freq);
                    }
                }
            }

            if new_freq > 0 {
                *freq_counts.entry(new_freq).or_insert(0) += 1;
            }

            if let Some((&max_f, _)) = freq_counts.iter().rev().next() {
                result.push(max_f);
            } else {
                result.push(0);
            }
        }

        result
    }
}