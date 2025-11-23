impl Solution {
    pub fn original_digits(s: String) -> String {
        let mut count = [0; 26];
        for c in s.chars() {
            count[(c as u8 - b'a') as usize] += 1;
        }

        let mut digits = [0; 10];

        digits[0] = count[('z' as u8 - b'a') as usize];
        digits[2] = count[('w' as u8 - b'a') as usize];
        digits[4] = count[('u' as u8 - b'a') as usize];
        digits[6] = count[('x' as u8 - b'a') as usize];
        digits[8] = count[('g' as u8 - b'a') as usize];

        digits[1] = count[('o' as u8 - b'a') as usize] - digits[0] - digits[2] - digits[4];
        digits[3] = count[('h' as u8 - b'a') as usize] - digits[8];
        digits[5] = count[('f' as u8 - b'a') as usize] - digits[4];
        digits[7] = count[('v' as u8 - b'a') as usize] - digits[5];
        digits[9] = count[('i' as u8 - b'a') as usize] - digits[5] - digits[6] - digits[8];

        let mut result = String::new();
        for i in 0..10 {
            for _ in 0..digits[i] {
                result.push_str(&i.to_string());
            }
        }

        result.chars().collect::<Vec<_>>().sort();

        result.into_iter().collect()
    }
}