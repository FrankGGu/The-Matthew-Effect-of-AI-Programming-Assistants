impl Solution {
    pub fn divisibility_array(word: String, m: i32) -> Vec<i32> {
        let n = word.len();
        let mut div = vec![0; n];
        let mut current_remainder: i64 = 0;
        let m_i64 = m as i64;

        for (i, c) in word.chars().enumerate() {
            let digit = (c as u8 - b'0') as i64;
            current_remainder = (current_remainder * 10 + digit) % m_i64;
            if current_remainder == 0 {
                div[i] = 1;
            } else {
                div[i] = 0;
            }
        }

        div
    }
}