use std::collections::HashMap;

impl Solution {
    pub fn min_operations(s: String) -> i32 {
        let mut freq = HashMap::new();
        for c in s.chars() {
            *freq.entry(c).or_insert(0) += 1;
        }

        let mut counts: Vec<i32> = freq.values().cloned().collect();
        counts.sort_by(|a, b| b.cmp(a));

        let mut min_ops = i32::MAX;
        for target_freq in 0..=counts[0] {
            let mut ops = 0;
            for &count in &counts {
                if count > target_freq {
                    ops += count - target_freq;
                } else if target_freq > 0 {
                     ops += count - target_freq;
                } else if count > 0{
                    ops += count;
                }
            }
            min_ops = min_ops.min(ops);
        }

        let mut ops = 0;
        for &count in &counts {
            ops += count;
        }
        min_ops = min_ops.min(ops);

        let mut ops = 0;
        for &count in &counts {
            ops += count;
        }
        min_ops = min_ops.min(ops);

        let mut ops = 0;
        for &count in &counts {
            ops += count;
        }
        if counts.len() == s.len(){
            min_ops = 0;
        }
        else {
                let mut ops = 0;
                for &count in &counts {
                    ops += count;
                }
                min_ops = min_ops.min(ops);
        }

        let mut min_ops = i32::MAX;

        for target_freq in 0..=*counts.iter().max().unwrap_or(&0) {
            let mut ops = 0;
            for &count in &counts {
                if count > target_freq {
                    ops += count - target_freq;
                } else if target_freq > 0 {
                }
                else if count > 0{
                    ops += count;
                }
            }
             if target_freq == 0 {
                 ops = 0;
                 for &count in &counts {
                     ops += count;
                 }
             }
            min_ops = min_ops.min(ops);
        }

        min_ops
    }
}