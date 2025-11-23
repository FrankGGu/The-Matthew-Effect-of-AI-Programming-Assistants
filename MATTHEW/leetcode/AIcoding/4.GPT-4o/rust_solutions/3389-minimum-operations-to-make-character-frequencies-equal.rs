impl Solution {
    pub fn min_operations(s: String) -> i32 {
        let mut freq = vec![0; 26];
        for ch in s.chars() {
            freq[ch as usize - 'a' as usize] += 1;
        }
        let max_freq = *freq.iter().max().unwrap();
        let n = s.len();
        n as i32 - max_freq
    }
}