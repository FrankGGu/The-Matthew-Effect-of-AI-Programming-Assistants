impl Solution {
    pub fn rearrange_k_substrings(s: String, k: i32, target: String) -> bool {
        if s.len() % k as usize != 0 || s.len() / k as usize != target.len() {
            return false;
        }
        let k = k as usize;
        let s_chars: Vec<char> = s.chars().collect();
        let target_chars: Vec<char> = target.chars().collect();
        let mut target_counts = vec![0; 26];
        for &c in &target_chars {
            target_counts[(c as u8 - b'a') as usize] += 1;
        }
        let mut window_counts = vec![0; 26];
        for i in 0..k {
            window_counts[(s_chars[i] as u8 - b'a') as usize] += 1;
        }
        let mut matches = 0;
        for i in 0..26 {
            if window_counts[i] == target_counts[i] {
                matches += 1;
            }
        }
        if matches == 26 {
            return true;
        }
        for i in k..s_chars.len() {
            let left_char = s_chars[i - k];
            let left_idx = (left_char as u8 - b'a') as usize;
            if window_counts[left_idx] == target_counts[left_idx] {
                matches -= 1;
            }
            window_counts[left_idx] -= 1;
            if window_counts[left_idx] == target_counts[left_idx] {
                matches += 1;
            }
            let right_char = s_chars[i];
            let right_idx = (right_char as u8 - b'a') as usize;
            if window_counts[right_idx] == target_counts[right_idx] {
                matches -= 1;
            }
            window_counts[right_idx] += 1;
            if window_counts[right_idx] == target_counts[right_idx] {
                matches += 1;
            }
            if matches == 26 {
                return true;
            }
        }
        false
    }
}