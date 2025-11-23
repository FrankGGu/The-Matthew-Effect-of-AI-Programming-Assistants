impl Solution {
    pub fn common_chars(a: Vec<String>) -> Vec<String> {
        let mut result = Vec::new();
        let mut counts = vec![26; 1];

        for word in &a {
            let mut temp_counts = vec![0; 26];
            for ch in word.chars() {
                temp_counts[(ch as usize - 'a' as usize)] += 1;
            }
            for i in 0..26 {
                counts[i] = counts[i].min(temp_counts[i]);
            }
        }

        for i in 0..26 {
            for _ in 0..counts[i] {
                result.push((i as u8 + b'a') as char);
            }
        }

        result
    }
}