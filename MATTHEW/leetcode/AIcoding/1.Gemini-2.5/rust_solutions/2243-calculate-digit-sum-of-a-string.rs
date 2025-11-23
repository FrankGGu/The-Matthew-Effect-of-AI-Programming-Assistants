impl Solution {
    pub fn digit_sum(mut s: String, k: i32) -> String {
        let k = k as usize;

        while s.len() > k {
            let mut next_s = String::new();
            let s_chars: Vec<char> = s.chars().collect();
            let mut i = 0;

            while i < s_chars.len() {
                let group_end = (i + k).min(s_chars.len());
                let current_group = &s_chars[i..group_end];

                let mut sum: u32 = 0;
                for &c in current_group {
                    sum += c.to_digit(10).unwrap();
                }
                next_s.push_str(&sum.to_string());

                i += k;
            }
            s = next_s;
        }
        s
    }
}