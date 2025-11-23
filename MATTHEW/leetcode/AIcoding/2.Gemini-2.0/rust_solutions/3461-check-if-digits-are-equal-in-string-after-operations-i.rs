impl Solution {
    pub fn are_digits_equal(s: String) -> bool {
        let n = s.len();
        let mut counts = vec![0; 10];
        for (i, c) in s.chars().enumerate() {
            let digit = (c as u8 - b'0') as usize;
            counts[digit] += i;
        }
        for i in 0..10 {
            if counts[i] > 0 && counts[i] != (0..n).sum::<usize>() {
                return false;
            }
        }
        true
    }
}