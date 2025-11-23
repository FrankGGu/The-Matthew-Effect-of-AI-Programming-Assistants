impl Solution {
    pub fn reverse_parentheses(s: String) -> String {
        let mut stack: Vec<String> = Vec::new();
        let mut current_segment: String = String::new();

        for c in s.chars() {
            match c {
                '(' => {
                    stack.push(current_segment);
                    current_segment = String::new();
                },
                ')' => {
                    current_segment = current_segment.chars().rev().collect();
                    let mut prev_segment = stack.pop().unwrap();
                    prev_segment.push_str(&current_segment);
                    current_segment = prev_segment;
                },
                _ => {
                    current_segment.push(c);
                }
            }
        }
        current_segment
    }
}