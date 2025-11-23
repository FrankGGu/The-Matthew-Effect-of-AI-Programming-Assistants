impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn longest_absolute_file_path(input: String) -> i32 {
        let mut stack = Vec::new();
        let mut max_length = 0;
        let mut lines = input.lines();

        while let Some(line) = lines.next() {
            let mut depth = 0;
            let mut i = 0;
            while i < line.len() && line.as_bytes()[i] == b'\t' {
                depth += 1;
                i += 1;
            }
            let name = &line[i..];
            let is_file = name.contains(".");
            if is_file {
                let mut current_length = 0;
                for i in 0..depth {
                    current_length += stack[i].len() + 1;
                }
                current_length += name.len();
                max_length = std::cmp::max(max_length, current_length);
            } else {
                if depth == 0 {
                    stack.clear();
                    stack.push(name.to_string());
                } else {
                    if depth < stack.len() {
                        stack.truncate(depth);
                    }
                    stack.push(name.to_string());
                }
            }
        }

        max_length as i32
    }
}
}