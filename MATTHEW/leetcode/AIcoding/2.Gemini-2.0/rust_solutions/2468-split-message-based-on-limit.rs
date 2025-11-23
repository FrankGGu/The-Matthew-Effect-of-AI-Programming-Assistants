impl Solution {
    pub fn split_message(message: String, limit: i32) -> Vec<String> {
        let n = message.len();
        let limit = limit as usize;

        let mut k = 1;
        while k <= n {
            let mut prefix_len = 0;
            let mut possible = true;
            for i in 1..=k {
                let num_digits = i.to_string().len();
                let total_digits = k.to_string().len() + num_digits + 3;
                if total_digits > limit {
                    possible = false;
                    break;
                }
                prefix_len = total_digits;
            }

            if !possible {
                k += 1;
                continue;
            }

            let chars_per_message = limit - prefix_len;
            let total_chars = chars_per_message * k;

            if total_chars >= n {
                break;
            }

            k += 1;
        }

        let mut result = Vec::new();
        let mut start = 0;
        for i in 1..=k {
            let num_digits = i.to_string().len();
            let total_digits = k.to_string().len() + num_digits + 3;
            let chars_per_message = limit as usize - total_digits;

            let end = std::cmp::min(start + chars_per_message, n);
            let sub_message = &message[start..end];

            let formatted_message = format!("{}/<{}/{}>", sub_message, i, k);
            result.push(formatted_message);

            start = end;
        }

        result
    }
}