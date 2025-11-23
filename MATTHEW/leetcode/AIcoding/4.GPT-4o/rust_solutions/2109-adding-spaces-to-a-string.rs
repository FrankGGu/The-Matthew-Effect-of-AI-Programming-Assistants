impl Solution {
    pub fn add_spaces(s: String, spaces: Vec<i32>) -> String {
        let mut result = String::new();
        let mut space_iter = spaces.iter();
        let mut space_index = space_iter.next();
        let mut current_index = 0;

        for c in s.chars() {
            if let Some(&index) = space_index {
                while current_index == index {
                    result.push(' ');
                    space_index = space_iter.next();
                    if space_index.is_none() {
                        break;
                    }
                }
            }
            result.push(c);
            current_index += 1;
        }

        result
    }
}