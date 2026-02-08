impl Solution {
    pub fn vowels_of_all_substrings(word: String) -> i64 {
        let n = word.len();
        let vowels: Vec<char> = vec!['a', 'e', 'i', 'o', 'u'];
        let mut ans: i64 = 0;
        for i in 0..n {
            if vowels.contains(&word.chars().nth(i).unwrap()) {
                ans += (i as i64 + 1) * (n as i64 - i as i64);
            }
        }
        ans
    }
}