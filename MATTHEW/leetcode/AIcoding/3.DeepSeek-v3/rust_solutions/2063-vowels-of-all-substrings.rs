impl Solution {
    pub fn count_vowels(word: String) -> i64 {
        let vowels: std::collections::HashSet<char> = ['a', 'e', 'i', 'o', 'u'].iter().cloned().collect();
        let mut res = 0i64;
        let n = word.len() as i64;
        for (i, c) in word.chars().enumerate() {
            if vowels.contains(&c) {
                let i = i as i64;
                res += (i + 1) * (n - i);
            }
        }
        res
    }
}