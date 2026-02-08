impl Solution {
    pub fn digit_count(num: String) -> bool {
        let mut counts = [0; 10];
        let bytes = num.as_bytes();
        for &b in bytes {
            counts[(b - b'0') as usize] += 1;
        }
        for (i, &b) in bytes.iter().enumerate() {
            if counts[i] != (b - b'0') as usize {
                return false;
            }
        }
        true
    }
}