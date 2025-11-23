impl Solution {
    pub fn count_divisible_substrings(word: String) -> i32 {
        let word = word.as_bytes();
        let n = word.len();
        let mut count = 0;

        for i in 0..n {
            let mut sum = 0;
            for j in i..n {
                let c = word[j] - b'a' + 1;
                sum += c;
                let last_digit = (word[j] - b'0') as i32;
                if last_digit != 0 && sum % last_digit == 0 {
                    count += 1;
                }
            }
        }

        count
    }
}