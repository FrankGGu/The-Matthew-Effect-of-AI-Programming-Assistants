impl Solution {
    pub fn substring_xor_queries(s: String, queries: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let s_bytes = s.as_bytes();
        let mut map = std::collections::HashMap::new();

        for len in 1..=std::cmp::min(32, s.len()) {
            for i in 0..=s.len() - len {
                let mut num = 0;
                for j in 0..len {
                    num = (num << 1) + (s_bytes[i + j] - b'0') as i32;
                }
                if !map.contains_key(&num) {
                    map.insert(num, vec![i as i32, (i + len - 1) as i32]);
                }
            }
        }

        let mut result = Vec::new();
        for query in queries {
            let val = query[0] ^ query[1];
            if let Some(indices) = map.get(&val) {
                result.push(indices.clone());
            } else {
                result.push(vec![-1, -1]);
            }
        }

        result
    }
}