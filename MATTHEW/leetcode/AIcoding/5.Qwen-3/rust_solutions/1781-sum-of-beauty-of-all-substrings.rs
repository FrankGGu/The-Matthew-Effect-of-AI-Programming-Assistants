impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn beauty_sum(s: String) -> i32 {
        let mut total = 0;
        let chars: Vec<char> = s.chars().collect();
        for i in 0..chars.len() {
            let mut freq = [0; 26];
            for j in i..chars.len() {
                let c = chars[j];
                freq[c as usize - 'a' as usize] += 1;
                let max_freq = freq.iter().max().unwrap();
                let min_freq = freq.iter().filter(|&&x| x > 0).min().unwrap();
                total += max_freq - min_freq;
            }
        }
        total
    }
}
}