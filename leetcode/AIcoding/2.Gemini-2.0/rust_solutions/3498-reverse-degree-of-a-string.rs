impl Solution {
    pub fn reverse_degree(s: String) -> i32 {
        let bytes = s.as_bytes();
        let mut count = 0;
        for i in 0..bytes.len() {
            for j in i + 1..bytes.len() {
                if bytes[i] > bytes[j] {
                    count += 1;
                }
            }
        }
        count
    }
}