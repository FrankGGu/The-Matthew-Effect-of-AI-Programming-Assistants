impl Solution {
    pub fn add_spaces(s: String, spaces: Vec<i32>) -> String {
        let mut result = String::with_capacity(s.len() + spaces.len());
        let mut last_idx = 0;

        for &space_pos_i32 in spaces.iter() {
            let space_pos = space_pos_i32 as usize;
            result.push_str(&s[last_idx..space_pos]);
            result.push(' ');
            last_idx = space_pos;
        }

        result.push_str(&s[last_idx..]);

        result
    }
}