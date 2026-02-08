impl Solution {
    pub fn longest_common_prefix(strs: Vec<String>) -> String {
        if strs.is_empty() {
            return String::new();
        }

        let char_vecs: Vec<Vec<char>> = strs.iter().map(|s| s.chars().collect()).collect();

        if char_vecs.len() == 1 {
            return strs[0].clone();
        }

        let first_chars = &char_vecs[0];

        for (i, &c) in first_chars.iter().enumerate() {
            for j in 1..char_vecs.len() {
                let current_chars = &char_vecs[j];
                if i >= current_chars.len() || current_chars[i] != c {
                    return first_chars[0..i].iter().collect();
                }
            }
        }

        first_chars.iter().collect()
    }
}