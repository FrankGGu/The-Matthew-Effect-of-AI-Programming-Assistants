impl Solution {
    pub fn rotated_digits(n: i32) -> i32 {
        let mut count = 0;
        for num in 1..=n {
            let s = num.to_string();
            if !s.contains('3') && !s.contains('4') && !s.contains('7') {
                if s.contains('2') || s.contains('5') || s.contains('6') || s.contains('9') {
                    count += 1;
                }
            }
        }
        count
    }
}