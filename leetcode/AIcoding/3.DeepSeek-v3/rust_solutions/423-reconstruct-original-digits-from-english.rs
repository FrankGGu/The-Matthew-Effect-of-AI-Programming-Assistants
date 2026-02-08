impl Solution {
    pub fn original_digits(s: String) -> String {
        let mut counts = [0; 26];
        for c in s.chars() {
            counts[(c as u8 - b'a') as usize] += 1;
        }

        let mut digits = vec![0; 10];
        digits[0] = counts[(b'z' - b'a') as usize];
        digits[2] = counts[(b'w' - b'a') as usize];
        digits[4] = counts[(b'u' - b'a') as usize];
        digits[6] = counts[(b'x' - b'a') as usize];
        digits[8] = counts[(b'g' - b'a') as usize];
        digits[3] = counts[(b'h' - b'a') as usize] - digits[8];
        digits[5] = counts[(b'f' - b'a') as usize] - digits[4];
        digits[7] = counts[(b's' - b'a') as usize] - digits[6];
        digits[1] = counts[(b'o' - b'a') as usize] - digits[0] - digits[2] - digits[4];
        digits[9] = counts[(b'i' - b'a') as usize] - digits[5] - digits[6] - digits[8];

        let mut result = String::new();
        for i in 0..10 {
            for _ in 0..digits[i] {
                result.push_str(&i.to_string());
            }
        }
        result
    }
}