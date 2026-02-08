struct Solution;

impl Solution {
    pub fn count_texts(pressed_keys: String) -> i32 {
        let n = pressed_keys.len();
        let chars: Vec<char> = pressed_keys.chars().collect();
        let modulus = 1_000_000_007;

        let mut dp3 = vec![0; n + 1];
        dp3[0] = 1;
        if n >= 1 {
            dp3[1] = 1;
        }
        if n >= 2 {
            dp3[2] = (dp3[1] + dp3[0]) % modulus;
        }
        for i in 3..=n {
            dp3[i] = (dp3[i - 1] + dp3[i - 2] + dp3[i - 3]) % modulus;
        }

        let mut dp4 = vec![0; n + 1];
        dp4[0] = 1;
        if n >= 1 {
            dp4[1] = 1;
        }
        if n >= 2 {
            dp4[2] = (dp4[1] + dp4[0]) % modulus;
        }
        if n >= 3 {
            dp4[3] = (dp4[2] + dp4[1] + dp4[0]) % modulus;
        }
        for i in 4..=n {
            dp4[i] = (dp4[i - 1] + dp4[i - 2] + dp4[i - 3] + dp4[i - 4]) % modulus;
        }

        let mut total_ways = 1;
        let mut i = 0;
        while i < n {
            let current_char = chars[i];
            let mut block_length = 0;
            while i + block_length < n && chars[i + block_length] == current_char {
                block_length += 1;
            }

            if current_char == '7' || current_char == '9' {
                total_ways = (total_ways * dp4[block_length]) % modulus;
            } else {
                total_ways = (total_ways * dp3[block_length]) % modulus;
            }
            i += block_length;
        }

        total_ways as i32
    }
}