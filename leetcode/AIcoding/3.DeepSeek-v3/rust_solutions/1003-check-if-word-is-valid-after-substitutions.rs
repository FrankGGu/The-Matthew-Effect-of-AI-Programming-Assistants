impl Solution {
    pub fn is_valid(s: String) -> bool {
        let mut stack = Vec::new();
        for c in s.chars() {
            stack.push(c);
            while stack.len() >= 3 && 
                  stack[stack.len() - 3] == 'a' && 
                  stack[stack.len() - 2] == 'b' && 
                  stack[stack.len() - 1] == 'c' {
                stack.pop();
                stack.pop();
                stack.pop();
            }
        }
        stack.is_empty()
    }
}