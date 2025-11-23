struct Solution;

impl Solution {
    pub fn halves_are_alike(s: String) -> bool {
        let n = s.len();
        let mid = n / 2;
        let a = &s[..mid];
        let b = &s[mid..];
        let vowels = ['a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U'];

        fn count_vowels(s: &str, vowels: &[char]) -> i32 {
            s.chars().filter(|c| vowels.contains(c)).count() as i32
        }

        count_vowels(a, &vowels) == count_vowels(b, &vowels)
    }
}