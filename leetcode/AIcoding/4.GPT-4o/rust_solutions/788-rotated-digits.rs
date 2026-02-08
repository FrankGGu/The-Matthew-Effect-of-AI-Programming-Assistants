impl Solution {
    pub fn rotated_digits(n: i32) -> i32 {
        let mut count = 0;
        for i in 1..=n {
            let s = i.to_string();
            if s.chars().any(|c| c == '3' || c == '4' || c == '7') {
                continue;
            }
            if s.chars().any(|c| c == '2' || c == '5' || c == '6' || c == '9') {
                count += 1;
            }
        }
        count
    }
}