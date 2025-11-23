use std::collections::HashMap;

impl Solution {
    pub fn record_decoration(record: Vec<Vec<i32>>) -> i32 {
        let mut count = HashMap::new();
        for r in record {
            let a = r[0];
            let b = r[1];
            let c = r[2];
            *count.entry((a, b)).or_insert(0) += c;
        }

        let mut ans = 0;
        for (_, v) in count {
            ans = ans.max(v);
        }

        ans
    }
}