impl Solution {
    pub fn beauty_sum(s: String) -> i32 {
        let n = s.len();
        let chars: Vec<char> = s.chars().collect();
        let mut total_beauty = 0;

        for i in 0..n {
            let mut freq = [0; 26]; // Frequency array for characters 'a' through 'z'
            for j in i..n {
                // Add current character to frequency count
                freq[(chars[j] as u8 - b'a') as usize] += 1;

                // Calculate max_freq and min_freq for the current substring chars[i..=j]
                let mut max_freq = 0;
                let mut min_freq = i32::MAX; 

                for &f in freq.iter() {
                    if f > 0 { // Only consider characters that actually appear in the substring
                        max_freq = max_freq.max(f);
                        min_freq = min_freq.min(f);
                    }
                }

                total_beauty += max_freq - min_freq;
            }
        }

        total_beauty
    }
}