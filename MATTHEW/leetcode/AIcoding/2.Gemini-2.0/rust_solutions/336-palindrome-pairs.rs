impl Solution {
    pub fn palindrome_pairs(words: Vec<String>) -> Vec<Vec<i32>> {
        let mut result: Vec<Vec<i32>> = Vec::new();
        let n = words.len();
        for i in 0..n {
            for j in 0..n {
                if i == j {
                    continue;
                }
                let combined = format!("{}{}", words[i], words[j]);
                if Solution::is_palindrome(&combined) {
                    result.push(vec![i as i32, j as i32]);
                }
            }
        }
        result
    }

    fn is_palindrome(s: &String) -> bool {
        let chars: Vec<char> = s.chars().collect();
        let n = chars.len();
        for i in 0..n / 2 {
            if chars[i] != chars[n - 1 - i] {
                return false;
            }
        }
        true
    }
}