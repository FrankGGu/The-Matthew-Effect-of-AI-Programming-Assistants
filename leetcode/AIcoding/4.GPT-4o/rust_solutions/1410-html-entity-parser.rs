impl Solution {
    pub fn entity_parser(text: String) -> String {
        let mut result = String::new();
        let mut i = 0;
        let n = text.len();
        let bytes = text.as_bytes();

        while i < n {
            if bytes[i] == b'&' {
                if i + 3 < n && &bytes[i + 1..i + 4] == b"amp" {
                    result.push('&');
                    i += 4;
                } else if i + 3 < n && &bytes[i + 1..i + 4] == b"gt;" {
                    result.push('>');
                    i += 4;
                } else if i + 3 < n && &bytes[i + 1..i + 4] == b"lt;" {
                    result.push('<');
                    i += 4;
                } else if i + 4 < n && &bytes[i + 1..i + 5] == b"quot;" {
                    result.push('"');
                    i += 5;
                } else if i + 5 < n && &bytes[i + 1..i + 6] == b"apos;" {
                    result.push('\'');
                    i += 6;
                } else {
                    result.push('&');
                    i += 1;
                }
            } else {
                result.push(bytes[i] as char);
                i += 1;
            }
        }
        result
    }
}