impl Solution {
    pub fn partition_string(s: String) -> i32 {
        let mut seen = [false; 26];
        let mut count = 1;
        for c in s.chars() {
            let idx = (c as u8 - b'a') as usize;
            if seen[idx] {
                seen.fill(false);
                count += 1;
            }
            seen[idx] = true;
        }
        count
    }
}