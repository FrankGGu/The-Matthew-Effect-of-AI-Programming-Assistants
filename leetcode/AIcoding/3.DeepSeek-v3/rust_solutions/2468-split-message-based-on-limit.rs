impl Solution {
    pub fn split_message(message: String, limit: i32) -> Vec<String> {
        let limit = limit as usize;
        let n = message.len();
        let mut parts = 0;
        let mut total = 0;

        for p in 1..=n {
            let suffix_len = 3 + (p as f64).log10().ceil() as usize * 2;
            if suffix_len >= limit {
                return vec![];
            }
            let max_content = limit - suffix_len;
            total += max_content;
            if total >= n {
                parts = p;
                break;
            }
        }

        if parts == 0 {
            return vec![];
        }

        let mut res = Vec::with_capacity(parts);
        let mut idx = 0;
        for p in 1..=parts {
            let suffix = format!("<{}/{}>", p, parts);
            let suffix_len = suffix.len();
            let content_len = limit - suffix_len;
            let end = std::cmp::min(idx + content_len, n);
            let part = format!("{}{}", &message[idx..end], suffix);
            res.push(part);
            idx = end;
        }

        res
    }
}