impl Solution {
    pub fn find_original_string(typed: String) -> String {
        let mut original = String::new();
        let typed_chars: Vec<char> = typed.chars().collect();
        let n = typed_chars.len();
        let mut i = 0;

        while i < n {
            original.push(typed_chars[i]);
            let mut j = i + 1;
            while j < n && typed_chars[j] == typed_chars[i] {
                j += 1;
            }
            i = j;
        }

        original
    }
}