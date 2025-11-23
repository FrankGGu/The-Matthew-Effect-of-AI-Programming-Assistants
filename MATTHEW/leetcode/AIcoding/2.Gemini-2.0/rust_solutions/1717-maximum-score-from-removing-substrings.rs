impl Solution {
    pub fn maximum_score(s: String, x: i32, y: i32) -> i32 {
        let s = s.as_bytes();
        let mut stack = Vec::new();
        let mut score = 0;

        if x > y {
            for &c in s {
                stack.push(c);
                while stack.len() >= 2 && stack[stack.len() - 2] == b'a' && stack[stack.len() - 1] == b'b' {
                    stack.pop();
                    stack.pop();
                    score += x;
                }
            }
            let mut temp_stack = Vec::new();
            while !stack.is_empty() {
                temp_stack.push(stack.remove(0));
            }
            while !temp_stack.is_empty() {
                stack.push(temp_stack.remove(0));
                while stack.len() >= 2 && stack[stack.len() - 2] == b'b' && stack[stack.len() - 1] == b'a' {
                    stack.pop();
                    stack.pop();
                    score += y;
                }
            }
        } else {
            for &c in s {
                stack.push(c);
                while stack.len() >= 2 && stack[stack.len() - 2] == b'b' && stack[stack.len() - 1] == b'a' {
                    stack.pop();
                    stack.pop();
                    score += y;
                }
            }
            let mut temp_stack = Vec::new();
            while !stack.is_empty() {
                temp_stack.push(stack.remove(0));
            }
            while !temp_stack.is_empty() {
                stack.push(temp_stack.remove(0));
                while stack.len() >= 2 && stack[stack.len() - 2] == b'a' && stack[stack.len() - 1] == b'b' {
                    stack.pop();
                    stack.pop();
                    score += x;
                }
            }
        }

        score
    }
}