impl Solution {
    pub fn remove_anagrams(words: Vec<String>) -> Vec<String> {
        let mut result: Vec<String> = Vec::new();
        if words.is_empty() {
            return result;
        }
        result.push(words[0].clone());
        for i in 1..words.len() {
            let prev = &result[result.len() - 1];
            let current = &words[i];
            if !is_anagram(prev, current) {
                result.push(current.clone());
            }
        }
        result
    }
}

fn is_anagram(s: &str, t: &str) -> bool {
    if s.len() != t.len() {
        return false;
    }
    let mut s_chars: Vec<char> = s.chars().collect();
    let mut t_chars: Vec<char> = t.chars().collect();
    s_chars.sort();
    t_chars.sort();
    s_chars == t_chars
}