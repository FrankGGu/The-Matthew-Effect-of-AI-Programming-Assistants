impl Solution {
    pub fn longest_common_prefix(strs: Vec<String>) -> String {
        if strs.is_empty() {
            return "".to_string();
        }

        let char_vecs: Vec<Vec<char>> = strs.iter().map(|s| s.chars().collect()).collect();

        let first_char_vec = &char_vecs[0];
        if first_char_vec.is_empty() {
            return "".to_string();
        }

        let mut lcp_len = 0;

        for (i, &char_from_first) in first_char_vec.iter().enumerate() {
            let mut is_common_at_this_pos = true;

            for j in 1..char_vecs.len() {
                let current_char_vec = &char_vecs[j];

                if i >= current_char_vec.len() || current_char_vec[i] != char_from_first {
                    is_common_at_this_pos = false;
                    break;
                }
            }

            if is_common_at_this_pos {
                lcp_len += 1;
            } else {
                break;
            }
        }

        first_char_vec[0..lcp_len].iter().collect()
    }
}