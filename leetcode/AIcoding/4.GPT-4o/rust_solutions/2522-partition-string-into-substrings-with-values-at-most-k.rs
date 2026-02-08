impl Solution {
    pub fn partition_string(s: String, k: i32) -> i32 {
        let mut count = 0;
        let mut current_sum = 0;
        let mut seen = [false; 26];

        for c in s.chars() {
            let value = (c as u8 - b'a') as i32;
            if seen[value as usize] || current_sum + value > k {
                count += 1;
                current_sum = 0;
                seen = [false; 26];
            }
            seen[value as usize] = true;
            current_sum += value;
        }

        count + 1
    }
}