impl Solution {
    pub fn minimum_time_to_initial_state(word: String, k: i32) -> i32 {
        let n = word.len();
        let k = k as usize;
        let word_bytes = word.as_bytes();
        let mut count = 0;
        let mut start = 0;
        while start < n {
            let mut match_len = 0;
            for i in 0..n - start {
                if word_bytes[i] == word_bytes[start + i] {
                    match_len += 1;
                } else {
                    break;
                }
            }

            if match_len == n - start {
                return count + 1;
            }

            start += k;
            count += 1;
        }
        count
    }
}