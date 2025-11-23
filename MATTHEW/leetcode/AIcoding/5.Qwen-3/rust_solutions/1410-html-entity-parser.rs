struct Solution;

impl Solution {
    pub fn entity_parser(text: String) -> String {
        use std::collections::HashMap;

        let mut map = HashMap::new();
        map.insert("&quot;", "\"");
        map.insert("&apos;", "'");
        map.insert("&amp;", "&");
        map.insert("&lt;", "<");
        map.insert("&gt;", ">");
        map.insert("&frasl;", "/");

        let mut result = String::new();
        let mut i = 0;
        while i < text.len() {
            if text.as_bytes()[i] == b'&' {
                let mut j = i + 1;
                while j < text.len() && text.as_bytes()[j] != b';' {
                    j += 1;
                }
                if j < text.len() {
                    let entity = &text[i..j + 1];
                    if let Some(replacement) = map.get(entity) {
                        result.push_str(replacement);
                    } else {
                        result.push_str(entity);
                    }
                    i = j + 1;
                    continue;
                }
            }
            result.push(text.as_bytes()[i] as char);
            i += 1;
        }
        result
    }
}