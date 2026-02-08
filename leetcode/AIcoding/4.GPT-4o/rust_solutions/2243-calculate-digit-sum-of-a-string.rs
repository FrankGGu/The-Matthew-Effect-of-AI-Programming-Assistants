impl Solution {
    pub fn digit_sum(s: String, k: i32) -> String {
        let k = k as usize;
        let mut result = s;

        while result.len() > k {
            let mut new_result = String::new();
            for chunk in result.as_bytes().chunks(k) {
                let sum: u32 = chunk.iter().map(|&b| (b - b'0') as u32).sum();
                new_result.push_str(&sum.to_string());
            }
            result = new_result;
        }

        result
    }
}