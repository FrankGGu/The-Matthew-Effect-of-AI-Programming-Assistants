impl Solution {
    pub fn minimum_time_to_initial_state(word: String, k: i32) -> i32 {
        let n = word.len();
        let k = k as usize;
        let word_bytes = word.as_bytes();
        let mut res = 1;

        while res * k < n {
            let mut is_valid = true;
            for i in res * k..n {
                if word_bytes[i] != word_bytes[i - res * k] {
                    is_valid = false;
                    break;
                }
            }
            if is_valid {
                return res as i32;
            }
            res += 1;
        }

        res as i32
    }
}