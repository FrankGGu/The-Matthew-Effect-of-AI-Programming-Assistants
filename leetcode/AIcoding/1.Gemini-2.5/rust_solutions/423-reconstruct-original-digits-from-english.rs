impl Solution {
    pub fn original_digits(s: String) -> String {
        let mut char_counts = [0; 26];
        for c in s.chars() {
            char_counts[(c as u8 - b'a') as usize] += 1;
        }

        let mut digit_counts = [0; 10];

        // Digits with unique identifying characters
        // zero (z)
        digit_counts[0] = char_counts[(b'z' - b'a') as usize];
        // two (w)
        digit_counts[2] = char_counts[(b'w' - b'a') as usize];
        // four (u)
        digit_counts[4] = char_counts[(b'u' - b'a') as usize];
        // six (x)
        digit_counts[6] = char_counts[(b'x' - b'a') as usize];
        // eight (g)
        digit_counts[8] = char_counts[(b'g' - b'a') as usize];

        // Digits whose identifying characters become unique after previous counts
        // three (h) - 'eight' also has 'h'
        digit_counts[3] = char_counts[(b'h' - b'a') as usize] - digit_counts[8];
        // five (f) - 'four' also has 'f'
        digit_counts[5] = char_counts[(b'f' - b'a') as usize] - digit_counts[4];
        // seven (s) - 'six' also has 's'
        digit_counts[7] = char_counts[(b's' - b'a') as usize] - digit_counts[6];

        // Remaining digits
        // one (o) - 'zero', 'two', 'four' also have 'o'
        digit_counts[1] = char_counts[(b'o' - b'a') as usize]
            - digit_counts[0]
            - digit_counts[2]
            - digit_counts[4];
        // nine (i) - 'five', 'six', 'eight' also have 'i'
        digit_counts[9] = char_counts[(b'i' - b'a') as usize]
            - digit_counts[5]
            - digit_counts[6]
            - digit_counts[8];

        let mut result = String::with_capacity(s.len());
        for i in 0..10 {
            for _ in 0..digit_counts[i] {
                result.push(std::char::from_digit(i as u32, 10).unwrap());
            }
        }

        result
    }
}