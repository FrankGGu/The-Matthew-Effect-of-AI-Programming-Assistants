impl Solution {
    pub fn repeated_substring_pattern(s: String) -> bool {
        let ss = format!("{}{}", s, s);
        let sub = &ss[1..ss.len()-1];
        sub.contains(&s)
    }
}