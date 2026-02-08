struct Solution;

impl Solution {
    pub fn min_operations(num1: i32, num2: i32) -> i32 {
        let s1 = num1.to_string();
        let s2 = num2.to_string();

        let len1 = s1.len();
        let len2 = s2.len();

        let max_len = len1.max(len2);

        let mut padded_s1 = String::with_capacity(max_len);
        let mut padded_s2 = String::with_capacity(max_len);

        for _ in 0..(max_len - len1) {
            padded_s1.push('0');
        }
        padded_s1.push_str(&s1);

        for _ in 0..(max_len - len2) {
            padded_s2.push('0');
        }
        padded_s2.push_str(&s2);

        let mut operations = 0;

        for i in 0..max_len {
            let d1 = padded_s1.chars().nth(i).unwrap().to_digit(10).unwrap() as i32;
            let d2 = padded_s2.chars().nth(i).unwrap().to_digit(10).unwrap() as i32;

            let diff = (d1 - d2).abs();
            operations += diff.min(10 - diff);
        }

        operations
    }
}