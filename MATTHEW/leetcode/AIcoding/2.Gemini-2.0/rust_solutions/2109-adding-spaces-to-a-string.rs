impl Solution {
    pub fn add_spaces(s: String, spaces: Vec<i32>) -> String {
        let mut result = String::new();
        let mut space_index = 0;
        let s_chars: Vec<char> = s.chars().collect();
        for i in 0..s_chars.len() {
            if space_index < spaces.len() && i as i32 == spaces[space_index] {
                result.push(' ');
                space_index += 1;
            }
            result.push(s_chars[i]);
        }
        result
    }
}