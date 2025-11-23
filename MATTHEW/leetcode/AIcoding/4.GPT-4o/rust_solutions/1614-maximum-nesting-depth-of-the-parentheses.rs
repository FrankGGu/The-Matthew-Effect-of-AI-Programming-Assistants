impl Solution {
    pub fn max_nesting_depth(s: String) -> i32 {
        let mut max_depth = 0;
        let mut current_depth = 0;

        for c in s.chars() {
            match c {
                '(' => {
                    current_depth += 1;
                    if current_depth > max_depth {
                        max_depth = current_depth;
                    }
                },
                ')' => current_depth -= 1,
                _ => {}
            }
        }

        max_depth
    }
}