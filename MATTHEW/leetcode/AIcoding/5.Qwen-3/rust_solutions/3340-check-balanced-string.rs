struct Solution;

impl Solution {
    pub fn is_balanced(s: String) -> bool {
        let mut count = 0;
        for c in s.chars() {
            match c {
                '(' => count += 1,
                ')' => {
                    if count == 0 {
                        return false;
                    }
                    count -= 1;
                },
                _ => {}
            }
        }
        count == 0
    }
}