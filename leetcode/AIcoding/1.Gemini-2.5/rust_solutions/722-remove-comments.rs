struct Solution;

impl Solution {
    pub fn remove_comments(source: Vec<String>) -> Vec<String> {
        let mut result: Vec<String> = Vec::new();
        let mut current_line_buffer: String = String::new();
        let mut in_block_comment: bool = false;

        for line in source {
            let mut chars = line.chars().peekable();
            while let Some(c) = chars.next() {
                if in_block_comment {
                    if c == '*' && chars.peek() == Some(&'/') {
                        chars.next(); // Consume '/'
                        in_block_comment = false;
                    }
                } else {
                    if c == '/' && chars.peek() == Some(&'/') {
                        chars.next(); // Consume '/'
                        break; // Line comment found, ignore rest of the line
                    } else if c == '/' && chars.peek() == Some(&'*') {
                        chars.next(); // Consume '*'
                        in_block_comment = true;
                    } else {
                        current_line_buffer.push(c);
                    }
                }
            }

            if !in_block_comment && !current_line_buffer.is_empty() {
                result.push(current_line_buffer.clone());
                current_line_buffer.clear();
            }
        }

        result
    }
}