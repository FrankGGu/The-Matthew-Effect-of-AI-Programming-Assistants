pub fn check_palindrome_strings(s: String, t: String) -> bool {
    fn dfs(s: &str, idx: usize, result: &mut String) {
        if idx >= s.len() {
            return;
        }
        result.push(s.chars().nth(idx).unwrap());
        dfs(s, idx + 1, result);
    }

    let mut s_result = String::new();
    let mut t_result = String::new();
    dfs(&s, 0, &mut s_result);
    dfs(&t, 0, &mut t_result);

    s_result == t_result.chars().rev().collect::<String>()
}