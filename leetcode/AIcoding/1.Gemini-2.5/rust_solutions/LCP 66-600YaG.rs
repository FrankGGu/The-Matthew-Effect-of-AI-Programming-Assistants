impl Solution {
    pub fn min_booths(words: Vec<String>) -> i32 {
        let mut global_max_freq: [i32; 26] = [0; 26];

        for word in words {
            let mut current_freq: [i32; 26] = [0; 26];
            for c in word.chars() {
                if c.is_ascii_lowercase() {
                    current_freq[(c as u8 - b'a') as usize] += 1;
                }
            }

            for i in 0..26 {
                global_max_freq[i] = global_max_freq[i].max(current_freq[i]);
            }
        }

        global_max_freq.iter().sum()
    }
}