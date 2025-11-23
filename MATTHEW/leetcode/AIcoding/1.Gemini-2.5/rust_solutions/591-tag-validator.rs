struct Solution;

impl Solution {
    pub fn is_valid(code: String) -> bool {
        let n = code.len();
        if n == 0 {
            return false;
        }

        let bytes = code.as_bytes();
        let mut i = 0;
        let mut tag_stack: Vec<String> = Vec::new();

        // Helper to validate tag name
        // Tag name must be 1-9 uppercase letters
        let is_valid_tag_name = |s: &str| -> bool {
            if s.is_empty() || s.len() > 9 {
                return false;
            }
            s.chars().all(|c| c.is_ascii_uppercase())
        };

        while i < n {
            // Rule: If tag_stack is empty and we are not at the very beginning (i.e., we've processed something),
            // and there's content remaining, it's invalid.
            // This handles cases like "<A></A>B" or "<A></A><B>" where content appears after the root tag closes.
            if tag_stack.is_empty() && i > 0 {
                return false;
            }

            // 1. Check for closing tag: </TAG_NAME>
            if i + 2 < n && bytes[i] == b'<' && bytes[i + 1] == b'/' {
                let end_tag_start = i + 2;
                let end_tag_end_option = code[end_tag_start..].find('>').map(|idx| end_tag_start + idx);

                if let Some(j) = end_tag_end_option {
                    let tag_name = &code[end_tag_start..j];
                    if !is_valid_tag_name(tag_name) {
                        return false;
                    }
                    if tag_stack.is_empty() || tag_stack.pop().unwrap() != tag_name {
                        return false;
                    }
                    i = j + 1;
                    continue;
                } else {
                    return false; // No matching '>' for closing tag
                }
            }

            // 2. Check for CDATA section: <![CDATA[...]]>
            if i + 9 <= n && bytes[i..i + 9] == b"<![CDATA["[..] {
                if tag_stack.is_empty() {
                    // CDATA must be inside a tag
                    return false;
                }
                let cdata_end_start = i + 9;
                let cdata_end_option = code[cdata_end_start..].find("]]>").map(|idx| cdata_end_start + idx);

                if let Some(j) = cdata_end_option {
                    i = j + 3;
                    continue;
                } else {
                    return false; // No matching "]]>" for CDATA
                }
            }

            // 3. Check for opening tag: <TAG_NAME>
            if i < n && bytes[i] == b'<' {
                let tag_name_start = i + 1;
                let tag_name_end_option = code[tag_name_start..].find('>').map(|idx| tag_name_start + idx);

                if let Some(j) = tag_name_end_option {
                    let tag_name = &code[tag_name_start..j];
                    if !is_valid_tag_name(tag_name) {
                        return false;
                    }
                    tag_stack.push(tag_name.to_string());
                    i = j + 1;
                    continue;
                } else {
                    return false; // No matching '>' for opening tag
                }
            }

            // 4. Plain text
            // If we are here, it's not a tag or CDATA. It must be plain text.
            // Plain text is only allowed if there's an open tag.
            if tag_stack.is_empty() {
                return false; // Plain text outside any tag
            }
            // Consume plain text until next '<' or end of string
            i += 1;
            while i < n && bytes[i] != b'<' {
                i += 1;
            }
        }

        // After loop, tag_stack must be empty
        tag_stack.is_empty()
    }
}