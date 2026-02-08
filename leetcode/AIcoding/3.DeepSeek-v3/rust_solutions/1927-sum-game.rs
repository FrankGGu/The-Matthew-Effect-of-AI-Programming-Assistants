impl Solution {
    pub fn sum_game(num: String) -> bool {
        let s = num.as_bytes();
        let n = s.len();
        let mut left_sum = 0;
        let mut right_sum = 0;
        let mut left_q = 0;
        let mut right_q = 0;

        for i in 0..n / 2 {
            if s[i] == b'?' {
                left_q += 1;
            } else {
                left_sum += (s[i] - b'0') as i32;
            }
        }

        for i in n / 2..n {
            if s[i] == b'?' {
                right_q += 1;
            } else {
                right_sum += (s[i] - b'0') as i32;
            }
        }

        let total_q = left_q + right_q;
        if total_q % 2 != 0 {
            return true;
        }

        let diff = left_sum - right_sum;
        let q_diff = left_q - right_q;

        if diff == -9 * q_diff / 2 {
            false
        } else {
            true
        }
    }
}