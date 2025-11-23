impl Solution {
    pub fn common_chars(words: Vec<String>) -> Vec<String> {
        let mut counts: [i32; 26] = [i32::MAX; 26];
        for word in words {
            let mut word_counts: [i32; 26] = [0; 26];
            for c in word.chars() {
                word_counts[(c as u8 - b'a') as usize] += 1;
            }
            for i in 0..26 {
                counts[i] = counts[i].min(word_counts[i]);
            }
        }

        let mut result: Vec<String> = Vec::new();
        for i in 0..26 {
            for _ in 0..counts[i] {
                result.push(String::from((b'a' + i as u8) as char));
            }
        }

        result
    }
}