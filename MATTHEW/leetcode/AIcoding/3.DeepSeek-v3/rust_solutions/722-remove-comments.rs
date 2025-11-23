impl Solution {
    pub fn remove_comments(source: Vec<String>) -> Vec<String> {
        let mut in_block = false;
        let mut res = Vec::new();
        let mut buffer = String::new();

        for line in source {
            let mut i = 0;
            let chars: Vec<char> = line.chars().collect();
            let n = chars.len();
            if !in_block {
                buffer.clear();
            }
            while i < n {
                if !in_block && i + 1 < n && chars[i] == '/' && chars[i + 1] == '*' {
                    in_block = true;
                    i += 2;
                } else if in_block && i + 1 < n && chars[i] == '*' && chars[i + 1] == '/' {
                    in_block = false;
                    i += 2;
                } else if !in_block && i + 1 < n && chars[i] == '/' && chars[i + 1] == '/' {
                    break;
                } else if !in_block {
                    buffer.push(chars[i]);
                    i += 1;
                } else {
                    i += 1;
                }
            }
            if !in_block && !buffer.is_empty() {
                res.push(buffer.clone());
            }
        }
        res
    }
}