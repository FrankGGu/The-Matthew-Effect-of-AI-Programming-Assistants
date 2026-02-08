use std::collections::HashMap;

impl Solution {
    pub fn substring_xor_queries(s: String, queries: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let s_bytes = s.as_bytes();
        let mut num_to_indices = HashMap::new();
        let n = s_bytes.len();

        for i in 0..n {
            if s_bytes[i] == b'0' {
                if !num_to_indices.contains_key(&0) {
                    num_to_indices.insert(0, vec![i as i32, i as i32]);
                }
                continue;
            }
            let mut num = 0;
            for j in i..std::cmp::min(i + 30, n) {
                num = (num << 1) | ((s_bytes[j] - b'0') as i32);
                num_to_indices.entry(num).or_insert(vec![i as i32, j as i32]);
            }
        }

        queries.into_iter().map(|query| {
            let val = query[0] ^ query[1];
            num_to_indices.get(&val).map_or(vec![-1, -1], |v| v.clone())
        }).collect()
    }
}