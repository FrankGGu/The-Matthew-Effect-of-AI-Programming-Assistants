struct Solution;

impl Solution {
    pub fn shortest_palindrome(s: String) -> String {
        let s = s.as_str();
        let mut temp = format!("{}#{}", s, s);
        let len = temp.len();
        let mut lps = vec![0; len];

        for i in 1..len {
            let mut j = lps[i - 1];
            while j > 0 && temp.chars().nth(i).unwrap() != temp.chars().nth(j).unwrap() {
                j = lps[j - 1];
            }
            if temp.chars().nth(i).unwrap() == temp.chars().nth(j).unwrap() {
                j += 1;
            }
            lps[i] = j;
        }

        let max_len = lps[len - 1];
        let suffix = &s[max_len..];
        let mut result = String::new();
        result.push_str(suffix);
        result.push_str(s);
        result
    }
}