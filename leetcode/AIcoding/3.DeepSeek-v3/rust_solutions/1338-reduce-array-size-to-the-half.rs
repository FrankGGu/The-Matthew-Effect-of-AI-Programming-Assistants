use std::collections::HashMap;

impl Solution {
    pub fn min_set_size(arr: Vec<i32>) -> i32 {
        let mut frequency = HashMap::new();
        for &num in &arr {
            *frequency.entry(num).or_insert(0) += 1;
        }
        let mut counts: Vec<i32> = frequency.values().cloned().collect();
        counts.sort_unstable_by(|a, b| b.cmp(a));
        let mut total = 0;
        let mut res = 0;
        let half = arr.len() / 2;
        for &count in &counts {
            total += count as usize;
            res += 1;
            if total >= half {
                break;
            }
        }
        res
    }
}