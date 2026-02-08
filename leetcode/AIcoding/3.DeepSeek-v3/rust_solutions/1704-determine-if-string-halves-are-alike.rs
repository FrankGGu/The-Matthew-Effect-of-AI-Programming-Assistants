impl Solution {
    pub fn halves_are_alike(s: String) -> bool {
        let vowels: [char; 10] = ['a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U'];
        let half = s.len() / 2;
        let a = &s[..half];
        let b = &s[half..];

        let count_a = a.chars().filter(|c| vowels.contains(c)).count();
        let count_b = b.chars().filter(|c| vowels.contains(c)).count();

        count_a == count_b
    }
}