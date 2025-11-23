struct Solution;

impl Solution {
    pub fn rotated_digits(n: i32) -> i32 {
        let mut count = 0;
        for i in 1..=n {
            let s = i.to_string();
            let mut has_invalid = false;
            let mut has_valid = false;
            for c in s.chars() {
                match c {
                    '2' | '5' | '6' | '9' => has_valid = true,
                    '3' | '4' | '7' => {
                        has_invalid = true;
                        break;
                    }
                    _ => {}
                }
            }
            if !has_invalid && has_valid {
                count += 1;
            }
        }
        count
    }
}