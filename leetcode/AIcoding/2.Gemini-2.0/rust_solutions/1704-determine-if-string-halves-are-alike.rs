impl Solution {
    pub fn halves_are_alike(s: String) -> bool {
        let vowels = "aeiouAEIOU";
        let n = s.len();
        let a = &s[0..n / 2];
        let b = &s[n / 2..n];

        let count_a = a.chars().filter(|&c| vowels.contains(c)).count();
        let count_b = b.chars().filter(|&c| vowels.contains(c)).count();

        count_a == count_b
    }
}