impl Solution {
    pub fn minimum_time_to_initial_state(word: String, k: i32) -> i32 {
        let n = word.len();
        let s = word.as_bytes();
        let k = k as usize;
        let mut res = 1;
        let max_possible = (n + k - 1) / k;

        for i in 1..=max_possible {
            let start = i * k;
            if start >= n {
                return i as i32;
            }
            let mut is_valid = true;
            for j in start..n {
                if s[j] != s[j - start] {
                    is_valid = false;
                    break;
                }
            }
            if is_valid {
                return i as i32;
            }
        }
        max_possible as i32
    }
}