impl Solution {
    pub fn partition_string(s: String, k: i32) -> i32 {
        let mut count = 1;
        let mut current_value: i64 = 0;
        let k_long = k as i64;

        for c in s.chars() {
            let digit = (c as u8 - b'0') as i64;

            if current_value * 10 + digit > k_long {
                count += 1;
                current_value = digit;
            } else {
                current_value = current_value * 10 + digit;
            }
        }

        count
    }
}