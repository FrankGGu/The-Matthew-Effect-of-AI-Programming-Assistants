impl Solution {
    pub fn minimize_string_value(s: String) -> String {
        let mut s_chars: Vec<char> = s.chars().collect();
        let mut freq = [0; 26];
        let mut question_marks = Vec::new();

        for &c in s_chars.iter() {
            if c != '?' {
                freq[(c as u8 - b'a') as usize] += 1;
            }
        }

        for i in 0..s_chars.len() {
            if s_chars[i] == '?' {
                let mut min_freq = i32::MAX;
                let mut min_char = 'a';
                for c in b'a'..=b'z' {
                    let idx = (c - b'a') as usize;
                    if freq[idx] < min_freq {
                        min_freq = freq[idx];
                        min_char = c as char;
                    }
                }
                question_marks.push(min_char);
                freq[(min_char as u8 - b'a') as usize] += 1;
            }
        }

        let mut q_idx = 0;
        for i in 0..s_chars.len() {
            if s_chars[i] == '?' {
                s_chars[i] = question_marks[q_idx];
                q_idx += 1;
            }
        }

        s_chars.into_iter().collect()
    }
}