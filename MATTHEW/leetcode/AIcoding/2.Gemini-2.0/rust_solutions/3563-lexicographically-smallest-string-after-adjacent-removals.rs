impl Solution {
    pub fn last_non_empty_string(s: String) -> String {
        let mut counts = vec![0; 26];
        for &b in s.as_bytes() {
            counts[(b - b'a') as usize] += 1;
        }

        let max_count = *counts.iter().max().unwrap();
        let mut result = String::new();
        for &b in s.as_bytes().iter().rev() {
            if counts[(b - b'a') as usize] == max_count {
                result.push(b as char);
                counts[(b - b'a') as usize] = 0;
            }
        }

        result.chars().rev().collect()
    }
}