impl Solution {
    pub fn digit_sum(s: String, k: i32) -> String {
        let mut s = s;
        while s.len() > k as usize {
            let mut next_s = String::new();
            let mut i = 0;
            while i < s.len() {
                let mut sum = 0;
                for j in 0..k {
                    if i + j as usize < s.len() {
                        sum += s.chars().nth(i + j as usize).unwrap().to_digit(10).unwrap();
                    } else {
                        break;
                    }
                }
                next_s.push_str(&sum.to_string());
                i += k as usize;
            }
            s = next_s;
        }
        s
    }
}