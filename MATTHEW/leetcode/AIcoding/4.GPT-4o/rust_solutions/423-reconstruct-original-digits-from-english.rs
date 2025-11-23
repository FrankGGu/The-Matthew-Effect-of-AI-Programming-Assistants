impl Solution {
    pub fn original_digits(s: String) -> String {
        let mut count = vec![0; 26];
        for c in s.chars() {
            count[c as usize - 'a' as usize] += 1;
        }

        let mut digits = vec![0; 10];
        digits[0] = count['z' as usize - 'a' as usize]; // zero
        digits[2] = count['w' as usize - 'a' as usize]; // two
        digits[4] = count['u' as usize - 'a' as usize]; // four
        digits[6] = count['x' as usize - 'a' as usize]; // six
        digits[8] = count['g' as usize - 'a' as usize]; // eight

        digits[3] = count['h' as usize - 'a' as usize] - digits[8]; // three
        digits[5] = count['f' as usize - 'a' as usize] - digits[4]; // five
        digits[7] = count['s' as usize - 'a' as usize] - digits[6]; // seven
        digits[1] = count['o' as usize - 'a' as usize] - digits[0] - digits[2] - digits[4]; // one
        digits[9] = count['i' as usize - 'a' as usize] - digits[5] - digits[6] - digits[8]; // nine

        let mut result = String::new();
        for i in 0..10 {
            result.push_str(&digits[i].to_string().repeat(digits[i]));
        }

        result.chars().sorted().collect()
    }
}