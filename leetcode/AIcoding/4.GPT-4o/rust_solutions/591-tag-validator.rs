struct Solution;

impl Solution {
    pub fn is_valid(s: String) -> bool {
        let mut stack: Vec<String> = Vec::new();
        let mut i = 0;
        let n = s.len();

        while i < n {
            if s[i..].starts_with('<') {
                let end_tag = s[i..].find('>');
                if end_tag.is_none() {
                    return false;
                }
                let end_tag = end_tag.unwrap();
                let tag = &s[i..i + end_tag + 1];
                if tag.starts_with("</") {
                    if stack.is_empty() || stack.last().unwrap() != &tag[2..tag.len() - 1] {
                        return false;
                    }
                    stack.pop();
                } else {
                    let tag_name_end = tag[1..].find(' ');
                    let tag_name = if let Some(end) = tag_name_end {
                        &tag[1..end + 1]
                    } else {
                        &tag[1..tag.len() - 1]
                    };
                    stack.push(tag_name.to_string());
                }
                i += end_tag + 1;
            } else {
                i += 1;
            }
        }
        stack.is_empty()
    }
}