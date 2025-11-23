impl Solution {
    pub fn longest_substring(s: String, k: i32) -> i32 {
        let s = s.chars().collect::<Vec<_>>();
        let n = s.len();
        let mut max_length = 0;

        for unique_chars in 1..=26 {
            let mut count = [0; 26];
            let mut left = 0;
            let mut right = 0;
            let mut unique = 0;
            let mut at_least_k = 0;

            while right < n {
                if count[(s[right] as u8 - b'a') as usize] == 0 {
                    unique += 1;
                }
                count[(s[right] as u8 - b'a') as usize] += 1;
                if count[(s[right] as u8 - b'a') as usize] == k {
                    at_least_k += 1;
                }

                while unique > unique_chars {
                    count[(s[left] as u8 - b'a') as usize] -= 1;
                    if count[(s[left] as u8 - b'a') as usize] == 0 {
                        unique -= 1;
                    }
                    if count[(s[left] as u8 - b'a') as usize] == k - 1 {
                        at_least_k -= 1;
                    }
                    left += 1;
                }

                if unique == unique_chars && unique == at_least_k {
                    max_length = max_length.max(right - left + 1);
                }
                right += 1;
            }
        }

        max_length
    }
}