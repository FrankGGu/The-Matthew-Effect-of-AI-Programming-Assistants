impl Solution {
    pub fn add_spaces(s: String, spaces: Vec<i32>) -> String {
        let mut result = String::new();
        let s_chars: Vec<char> = s.chars().collect();
        let mut space_ptr = 0;

        for (i, &c) in s_chars.iter().enumerate() {
            if space_ptr < spaces.len() && i == spaces[space_ptr] as usize {
                result.push(' ');
                space_ptr += 1;
            }
            result.push(c);
        }

        result
    }
}