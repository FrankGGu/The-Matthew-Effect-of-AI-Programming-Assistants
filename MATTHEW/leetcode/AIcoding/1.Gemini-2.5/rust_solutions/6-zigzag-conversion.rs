impl Solution {
    pub fn convert(s: String, num_rows: i32) -> String {
        if num_rows == 1 {
            return s;
        }

        let chars: Vec<char> = s.chars().collect();
        let n = chars.len();
        let num_rows_usize = num_rows as usize;
        let mut result_chars: Vec<char> = Vec::with_capacity(n);

        let cycle_len = 2 * (num_rows_usize - 1);

        for r in 0..num_rows_usize {
            let mut j = r;
            while j < n {
                result_chars.push(chars[j]);

                if r != 0 && r != num_rows_usize - 1 {
                    let next_up_idx = j + cycle_len - 2 * r;
                    if next_up_idx < n {
                        result_chars.push(chars[next_up_idx]);
                    }
                }

                j += cycle_len;
            }
        }

        result_chars.into_iter().collect()
    }
}