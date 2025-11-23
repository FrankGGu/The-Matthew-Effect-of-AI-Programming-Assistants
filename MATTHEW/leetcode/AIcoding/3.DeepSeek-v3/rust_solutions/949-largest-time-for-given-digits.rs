impl Solution {
    pub fn largest_time_from_digits(a: Vec<i32>) -> String {
        let mut max_time = -1;
        let mut digits = a;
        Self::permute(&mut digits, 0, &mut max_time);
        if max_time == -1 {
            String::new()
        } else {
            format!("{:02}:{:02}", max_time / 60, max_time % 60)
        }
    }

    fn permute(digits: &mut Vec<i32>, start: usize, max_time: &mut i32) {
        if start == digits.len() {
            let h = digits[0] * 10 + digits[1];
            let m = digits[2] * 10 + digits[3];
            if h < 24 && m < 60 {
                *max_time = (*max_time).max(h * 60 + m);
            }
            return;
        }
        for i in start..digits.len() {
            digits.swap(start, i);
            Self::permute(digits, start + 1, max_time);
            digits.swap(start, i);
        }
    }
}