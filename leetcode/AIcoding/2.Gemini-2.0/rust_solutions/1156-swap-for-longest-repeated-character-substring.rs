impl Solution {
    pub fn max_rep_opt1(text: String) -> i32 {
        let n = text.len();
        let text_bytes = text.as_bytes();
        let mut count = std::collections::HashMap::new();
        for &c in text_bytes {
            *count.entry(c).or_insert(0) += 1;
        }

        let mut max_len = 0;
        for i in 0..n {
            let mut curr_len = 1;
            let mut diff = 0;
            for j in i + 1..n {
                if text_bytes[i] == text_bytes[j] {
                    curr_len += 1;
                } else {
                    diff += 1;
                    if diff > 1 {
                        break;
                    }
                }
            }

            if diff == 0 {
                max_len = max_len.max(curr_len);
            } else {
                let char_count = *count.get(&text_bytes[i]).unwrap_or(&0);
                max_len = max_len.max(std::cmp::min(curr_len, char_count as i32));
            }
        }
        max_len as i32
    }
}