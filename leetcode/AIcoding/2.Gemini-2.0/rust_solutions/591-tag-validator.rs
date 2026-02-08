impl Solution {
    pub fn is_valid(code: String) -> bool {
        let mut tags = Vec::new();
        let mut i = 0;
        let code_bytes = code.as_bytes();

        if code.len() < 7 || !code.starts_with("<") || !code.ends_with(">") {
            return false;
        }

        while i < code_bytes.len() {
            if code_bytes[i] == b'<' {
                if i + 1 < code_bytes.len() && code_bytes[i + 1] == b'/' {
                    let j = code[i..].find(">").unwrap_or(code.len() - i) + i;
                    if j == i + 2 || j - i - 2 > 9 {
                        return false;
                    }
                    let tag_name = &code[i + 2..j];
                    if tags.is_empty() || tags.last().unwrap() != tag_name {
                        return false;
                    }
                    tags.pop();
                    i = j + 1;
                    if tags.is_empty() && i < code_bytes.len() {
                        return false;
                    }
                } else if i + 1 < code_bytes.len() && code_bytes[i + 1] != b'!' {
                    let j = code[i..].find(">").unwrap_or(code.len() - i) + i;
                    if j == i + 1 || j - i - 1 > 9 {
                        return false;
                    }
                    let tag_name = &code[i + 1..j];
                    for &b in tag_name.as_bytes() {
                        if !b.is_ascii_uppercase() {
                            return false;
                        }
                    }
                    tags.push(tag_name.to_string());
                    i = j + 1;
                } else if i + 8 < code_bytes.len() && code[i + 1..i + 9] == "!CDATA[" {
                    let j = code[i..].find("]]>").unwrap_or(code.len() - i) + i;
                    if j == code.len() - i {
                        return false;
                    }
                    i = j + 3;
                } else {
                    return false;
                }
            } else {
                if tags.is_empty() {
                    return false;
                }
                i += 1;
            }
        }

        tags.is_empty()
    }
}