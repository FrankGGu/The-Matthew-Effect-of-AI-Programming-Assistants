impl Solution {
    pub fn add_spaces(s: String, spaces: Vec<i32>) -> String {
        let mut result = String::new();
        let mut space_idx = 0;
        let s_chars: Vec<char> = s.chars().collect();
        let len = s_chars.len();

        for i in 0..len {
            if space_idx < spaces.len() && i as i32 == spaces[space_idx] {
                result.push(' ');
                space_idx += 1;
            }
            result.push(s_chars[i]);
        }

        result
    }
}