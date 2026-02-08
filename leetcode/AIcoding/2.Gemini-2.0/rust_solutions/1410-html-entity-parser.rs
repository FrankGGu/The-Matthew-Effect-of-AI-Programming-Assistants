impl Solution {
    pub fn entity_parser(text: String) -> String {
        let mut result = String::new();
        let mut i = 0;
        while i < text.len() {
            if text[i..].starts_with("&quot;") {
                result.push('"');
                i += 6;
            } else if text[i..].starts_with("&apos;") {
                result.push('\'');
                i += 6;
            } else if text[i..].starts_with("&amp;") {
                result.push('&');
                i += 5;
            } else if text[i..].starts_with("&gt;") {
                result.push('>');
                i += 4;
            } else if text[i..].starts_with("&lt;") {
                result.push('<');
                i += 4;
            } else if text[i..].starts_with("&frasl;") {
                result.push('/');
                i += 8;
            } else {
                result.push(text.chars().nth(i).unwrap());
                i += 1;
            }
        }
        result
    }
}