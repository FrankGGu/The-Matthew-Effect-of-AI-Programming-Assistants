use std::collections::VecDeque;

impl Solution {
    pub fn is_valid(code: String) -> bool {
        let mut stack: VecDeque<String> = VecDeque::new();
        let n = code.len();
        let mut i = 0;
        while i < n {
            if i > 0 && stack.is_empty() {
                return false;
            }
            if code[i..].starts_with("<![CDATA[") {
                let j = i + 9;
                i = j;
                while i + 3 <= n && !code[i..].starts_with("]]>") {
                    i += 1;
                }
                if i + 3 > n {
                    return false;
                }
                i += 3;
            } else if code[i..].starts_with("</") {
                let j = i + 2;
                i = j;
                while i < n && code.as_bytes()[i] != b'>' {
                    if !code.as_bytes()[i].is_ascii_uppercase() {
                        return false;
                    }
                    i += 1;
                }
                if i == n {
                    return false;
                }
                let tag = &code[j..i];
                if stack.is_empty() || stack.pop_back().unwrap() != tag {
                    return false;
                }
                i += 1;
            } else if code[i..].starts_with("<") {
                let j = i + 1;
                i = j;
                while i < n && code.as_bytes()[i] != b'>' {
                    if !code.as_bytes()[i].is_ascii_uppercase() {
                        return false;
                    }
                    i += 1;
                }
                if i == n {
                    return false;
                }
                let tag = &code[j..i];
                if tag.len() < 1 || tag.len() > 9 {
                    return false;
                }
                stack.push_back(tag.to_string());
                i += 1;
            } else {
                i += 1;
            }
        }
        stack.is_empty()
    }
}