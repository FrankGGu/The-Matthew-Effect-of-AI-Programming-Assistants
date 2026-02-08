impl Solution {
    pub fn repeated_string_match(a: String, b: String) -> i32 {
        let a_chars: Vec<char> = a.chars().collect();
        let b_chars: Vec<char> = b.chars().collect();
        let max_repeat = (b.len() / a.len()).max(1) + 2;
        let mut repeated = String::new();

        for i in 0..max_repeat {
            repeated.push_str(&a);
            if repeated.len() >= b.len() {
                if repeated.contains(&b) {
                    return (i + 1) as i32;
                }
            }
        }

        -1
    }
}