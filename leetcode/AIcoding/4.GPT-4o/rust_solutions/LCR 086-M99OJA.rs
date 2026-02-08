pub fn partition(s: String) -> Vec<Vec<String>> {
    let mut result = Vec::new();
    let mut current = Vec::new();
    backtrack(&s, 0, &mut current, &mut result);
    result
}

fn backtrack(s: &str, start: usize, current: &mut Vec<String>, result: &mut Vec<Vec<String>>) {
    if start >= s.len() {
        result.push(current.clone());
        return;
    }

    for end in start + 1..=s.len() {
        let substring = &s[start..end];
        if is_palindrome(substring) {
            current.push(substring.to_string());
            backtrack(s, end, current, result);
            current.pop();
        }
    }
}

fn is_palindrome(s: &str) -> bool {
    s == s.chars().rev().collect::<String>().as_str()
}