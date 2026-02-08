impl Solution {
    pub fn count_vowels(s: String) -> i64 {
        let mut total = 0;
        let n = s.len() as i64;
        for i in 0..n {
            if "aeiou".contains(s.chars().nth(i as usize).unwrap()) {
                total += (i + 1) * (n - i);
            }
        }
        total
    }
}