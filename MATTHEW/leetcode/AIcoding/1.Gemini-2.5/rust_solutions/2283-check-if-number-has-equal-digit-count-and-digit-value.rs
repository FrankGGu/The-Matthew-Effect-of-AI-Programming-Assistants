impl Solution {
    pub fn digit_count(num: String) -> bool {
        let n = num.len();
        let num_bytes = num.as_bytes();

        let mut counts: [usize; 10] = [0; 10];

        for &byte_char in num_bytes.iter() {
            let digit = (byte_char - b'0') as usize;
            counts[digit] += 1;
        }

        for i in 0..n {
            let target_count = (num_bytes[i] - b'0') as usize;
            let actual_count = counts[i];

            if target_count != actual_count {
                return false;
            }
        }

        true
    }
}