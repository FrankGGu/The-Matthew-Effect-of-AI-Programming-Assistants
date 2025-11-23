impl Solution {
    pub fn sort_string(s: String) -> String {
        let mut counts = [0; 26];
        for &b in s.as_bytes() {
            counts[(b - b'a') as usize] += 1;
        }

        let mut result = String::new();
        while result.len() < s.len() {
            for i in 0..26 {
                if counts[i] > 0 {
                    result.push((b'a' + i as u8) as char);
                    counts[i] -= 1;
                }
            }
            for i in (0..26).rev() {
                if counts[i] > 0 {
                    result.push((b'a' + i as u8) as char);
                    counts[i] -= 1;
                }
            }
        }
        result
    }
}