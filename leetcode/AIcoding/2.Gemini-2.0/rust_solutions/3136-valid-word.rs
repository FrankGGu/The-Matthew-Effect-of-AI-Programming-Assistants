impl Solution {
    pub fn is_valid_word(word: String) -> bool {
        let n = word.len();
        if n == 0 {
            return false;
        }

        let bytes = word.as_bytes();
        let mut stack: Vec<u8> = Vec::new();

        for &b in bytes {
            if b == b'c' {
                if stack.len() >= 2 && stack[stack.len() - 1] == b'b' && stack[stack.len() - 2] == b'a' {
                    stack.pop();
                    stack.pop();
                } else {
                    return false;
                }
            } else if b == b'a' || b == b'b' {
                stack.push(b);
            } else {
                return false;
            }
        }

        stack.is_empty()
    }
}