impl Solution {
    pub fn max_rep_opt1(text: String) -> i32 {
        let text: Vec<char> = text.chars().collect();
        let mut count = [0; 26];
        for &c in &text {
            count[(c as u8 - b'a') as usize] += 1;
        }

        let mut res = 0;
        let mut i = 0;
        while i < text.len() {
            let mut j = i;
            while j < text.len() && text[j] == text[i] {
                j += 1;
            }
            let curr_len = j - i;
            if curr_len < count[(text[i] as u8 - b'a') as usize] && (j < text.len() || i > 0) {
                res = res.max(curr_len + 1);
            } else {
                res = res.max(curr_len);
            }

            let mut k = j + 1;
            while k < text.len() && text[k] == text[i] {
                k += 1;
            }
            let combined_len = (j - i) + (k - j - 1);
            res = res.max(combined_len.min(count[(text[i] as u8 - b'a') as usize]));
            i = j;
        }
        res as i32
    }
}