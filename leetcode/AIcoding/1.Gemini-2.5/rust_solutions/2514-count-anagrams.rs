impl Solution {
    pub fn find_anagrams(s: String, p: String) -> Vec<i32> {
        let n = s.len();
        let m = p.len();

        if m > n {
            return Vec::new();
        }

        let s_chars: Vec<char> = s.chars().collect();
        let p_chars: Vec<char> = p.chars().collect();

        let mut p_freq = [0; 26];
        let mut window_freq = [0; 26];

        for i in 0..m {
            p_freq[(p_chars[i] as u8 - b'a') as usize] += 1;
            window_freq[(s_chars[i] as u8 - b'a') as usize] += 1;
        }

        let mut result = Vec::new();
        let mut matches = 0;

        for i in 0..26 {
            if p_freq[i] == window_freq[i] {
                matches += 1;
            }
        }

        if matches == 26 {
            result.push(0);
        }

        for i in m..n {
            let char_to_remove_idx = (s_chars[i - m] as u8 - b'a') as usize;
            let char_to_add_idx = (s_chars[i] as u8 - b'a') as usize;

            if p_freq[char_to_remove_idx] == window_freq[char_to_remove_idx] {
                matches -= 1;
            }
            window_freq[char_to_remove_idx] -= 1;
            if p_freq[char_to_remove_idx] == window_freq[char_to_remove_idx] {
                matches += 1;
            }

            if p_freq[char_to_add_idx] == window_freq[char_to_add_idx] {
                matches -= 1;
            }
            window_freq[char_to_add_idx] += 1;
            if p_freq[char_to_add_idx] == window_freq[char_to_add_idx] {
                matches += 1;
            }

            if matches == 26 {
                result.push((i - m + 1) as i32);
            }
        }

        result
    }
}