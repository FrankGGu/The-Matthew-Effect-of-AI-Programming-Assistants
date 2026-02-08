use std::collections::HashSet;

pub fn permutation(s: String) -> Vec<String> {
    let mut result = HashSet::new();
    let chars: Vec<char> = s.chars().collect();
    backtrack(&chars, 0, &mut result);
    result.into_iter().collect()
}

fn backtrack(chars: &[char], start: usize, result: &mut HashSet<String>) {
    if start == chars.len() {
        result.insert(chars.iter().collect());
        return;
    }
    let mut seen = HashSet::new();
    for i in start..chars.len() {
        if seen.insert(chars[i]) {
            let mut chars = chars.to_vec();
            chars.swap(start, i);
            backtrack(&chars, start + 1, result);
        }
    }
}