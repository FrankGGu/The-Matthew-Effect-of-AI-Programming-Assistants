impl Solution {
    pub fn entity_parser(text: String) -> String {
        let mut result = String::new();
        let mut i = 0;
        let n = text.len();
        let chars: Vec<char> = text.chars().collect();

        while i < n {
            if chars[i] == '&' {
                if i + 3 < n && &chars[i..i+4] == ['&', 'g', 't', ';'] {
                    result.push('>');
                    i += 4;
                } else if i + 3 < n && &chars[i..i+4] == ['&', 'l', 't', ';'] {
                    result.push('<');
                    i += 4;
                } else if i + 4 < n && &chars[i..i+5] == ['&', 'a', 'm', 'p', ';'] {
                    result.push('&');
                    i += 5;
                } else if i + 5 < n && &chars[i..i+6] == ['&', 'q', 'u', 'o', 't', ';'] {
                    result.push('"');
                    i += 6;
                } else if i + 5 < n && &chars[i..i+6] == ['&', 'a', 'p', 'o', 's', ';'] {
                    result.push('\'');
                    i += 6;
                } else if i + 6 < n && &chars[i..i+7] == ['&', 'f', 'r', 'a', 's', 'l', ';'] {
                    result.push('/');
                    i += 7;
                } else {
                    result.push('&');
                    i += 1;
                }
            } else {
                result.push(chars[i]);
                i += 1;
            }
        }
        result
    }
}