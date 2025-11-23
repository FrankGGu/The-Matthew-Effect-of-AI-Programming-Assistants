impl Solution {
    pub fn count_substrings_divisible_by_last_digit(word: String) -> i32 {
        let n = word.len();
        let chars: Vec<char> = word.chars().collect();
        let mut count = 0;
        for i in 0..n {
            for j in i..n {
                let sub: String = chars[i..=j].iter().collect();
                let last_digit = chars[j].to_digit(10).unwrap() as i32;
                if last_digit != 0 {
                    let num: i32 = sub.parse().unwrap();
                    if num % last_digit == 0 {
                        count += 1;
                    }
                }
            }
        }
        count
    }
}