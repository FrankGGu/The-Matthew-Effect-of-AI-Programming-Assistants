impl Solution {
    pub fn score_of_string(s: String) -> i32 {
        let bytes = s.as_bytes();
        let mut score = 0;
        let mut balance = 0;

        for &byte in bytes {
            if byte == b'(' {
                balance += 1;
            } else {
                balance -= 1;
                if bytes[balance as usize] == b'(' {
                    if balance == 0 {
                        score += 1;
                    } else {
                        score += 1 << balance;
                    }
                }
            }
        }

        score
    }
}