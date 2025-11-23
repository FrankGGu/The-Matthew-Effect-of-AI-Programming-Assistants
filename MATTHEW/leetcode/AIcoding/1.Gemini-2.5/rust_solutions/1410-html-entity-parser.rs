impl Solution {
    pub fn html_entity_parser(text: String) -> String {
        let mut result = String::new();
        let chars: Vec<char> = text.chars().collect();
        let n = chars.len();
        let mut i = 0;

        while i < n {
            if chars[i] == '&' {
                // Check for entities. Order matters for efficiency or if there were overlapping prefixes,
                // but for these specific distinct entities, any order that correctly identifies them is fine.
                // We check for the specific sequence of characters.
                if i + 6 < n && chars[i+1] == 'f' && chars[i+2] == 'r' && chars[i+3] == 'a' && chars[i+4] == 's' && chars[i+5] == 'l' && chars[i+6] == ';' {
                    result.push('/');
                    i += 7;
                } else if i + 5 < n && chars[i+1] == 'q' && chars[i+2] == 'u' && chars[i+3] == 'o' && chars[i+4] == 't' && chars[i+5] == ';' {
                    result.push('"');
                    i += 6;
                } else if i + 5 < n && chars[i+1] == 'a' && chars[i+2] == 'p' && chars[i+3] == 'o' && chars[i+4] == 's' && chars[i+5] == ';' {
                    result.push('\'');
                    i += 6;
                } else if i + 4 < n && chars[i+1] == 'a' && chars[i+2] == 'm' && chars[i+3] == 'p' && chars[i+4] == ';' {
                    result.push('&');
                    i += 5;
                } else if i + 3 < n && chars[i+1] == 'g' && chars[i+2] == 't' && chars[i+3] == ';' {
                    result.push('>');
                    i += 4;
                } else if i + 3 < n && chars[i+1] == 'l' && chars[i+2] == 't' && chars[i+3] == ';' {
                    result.push('<');
                    i += 4;
                } else {
                    // Not a recognized entity, append the '&' character itself
                    result.push(chars[i]);
                    i += 1;
                }
            } else {
                // Not an '&' character, append it directly
                result.push(chars[i]);
                i += 1;
            }
        }

        result
    }
}