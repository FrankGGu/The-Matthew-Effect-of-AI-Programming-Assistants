impl Solution {
    pub fn digit_sum(s: String, k: i32) -> String {
        let mut s = s;
        while s.len() > k as usize {
            let mut new_s = String::new();
            let mut i = 0;
            while i < s.len() {
                let end = std::cmp::min(i + k as usize, s.len());
                let group = &s[i..end];
                let sum: i32 = group.chars().map(|c| c.to_digit(10).unwrap()).sum::<u32>() as i32;
                new_s.push_str(&sum.to_string());
                i += k as usize;
            }
            s = new_s;
        }
        s
    }
}