impl Solution {
    pub fn beautiful_indices(s: String, a: String, b: String, k: i32) -> Vec<i32> {
        let s_bytes = s.as_bytes();
        let a_bytes = a.as_bytes();
        let b_bytes = b.as_bytes();

        let mut a_indices: Vec<i32> = Vec::new();
        let mut b_indices: Vec<i32> = Vec::new();

        for i in 0..=s_bytes.len() - a_bytes.len() {
            if &s_bytes[i..i + a_bytes.len()] == a_bytes {
                a_indices.push(i as i32);
            }
        }

        for i in 0..=s_bytes.len() - b_bytes.len() {
            if &s_bytes[i..i + b_bytes.len()] == b_bytes {
                b_indices.push(i as i32);
            }
        }

        let mut result: Vec<i32> = Vec::new();

        for &a_index in &a_indices {
            for &b_index in &b_indices {
                if (a_index - b_index).abs() <= k {
                    result.push(a_index);
                    break;
                }
            }
        }

        result.sort();
        result.dedup();
        result
    }
}