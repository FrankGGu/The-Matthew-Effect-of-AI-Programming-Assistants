struct Solution;

impl Solution {
    pub fn fizz_buzz(n: i32) -> Vec<String> {
        let mut result = Vec::new();
        for i in 1..=n {
            let mut s = String::new();
            if i % 3 == 0 {
                s.push_str("Fizz");
            }
            if i % 5 == 0 {
                s.push_str("Buzz");
            }
            if s.is_empty() {
                s = i.to_string();
            }
            result.push(s);
        }
        result
    }
}