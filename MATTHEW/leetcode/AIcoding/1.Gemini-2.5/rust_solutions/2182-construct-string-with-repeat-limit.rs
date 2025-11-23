impl Solution {
    pub fn repeat_limit(s: String, repeat_limit: i32) -> String {
        let mut counts = [0; 26];
        for c in s.chars() {
            counts[(c as u8 - b'a') as usize] += 1;
        }

        let mut res = String::new();
        let repeat_limit_usize = repeat_limit as usize;

        loop {
            let mut current_char_idx = -1;
            for i in (0..26).rev() {
                if counts[i] > 0 {
                    current_char_idx = i as i32;
                    break;
                }
            }

            if current_char_idx == -1 {
                break;
            }

            let current_char_idx_usize = current_char_idx as usize;
            let char_to_append = (b'a' + current_char_idx as u8) as char;

            let mut appended_count = 0;
            while appended_count < repeat_limit_usize && counts[current_char_idx_usize] > 0 {
                res.push(char_to_append);
                counts[current_char_idx_usize] -= 1;
                appended_count += 1;
            }

            if counts[current_char_idx_usize] > 0 {
                let mut next_char_idx = -1;
                for j in (0..current_char_idx_usize).rev() {
                    if counts[j] > 0 {
                        next_char_idx = j as i32;
                        break;
                    }
                }

                if next_char_idx == -1 {
                    break;
                } else {
                    let next_char_idx_usize = next_char_idx as usize;
                    res.push((b'a' + next_char_idx as u8) as char);
                    counts[next_char_idx_usize] -= 1;
                }
            }
        }

        res
    }
}