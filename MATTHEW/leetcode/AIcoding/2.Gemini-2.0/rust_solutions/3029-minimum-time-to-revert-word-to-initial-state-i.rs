impl Solution {
    pub fn minimum_time_to_initial_state(word: String, k: i32) -> i32 {
        let n = word.len();
        let k = k as usize;
        let mut count = 0;
        let mut i = k;
        while i < n {
            if word[i..].starts_with(&word[..n - i]) {
                count += 1;
                break;
            }
            count += 1;
            i += k;
        }
        count
    }
}