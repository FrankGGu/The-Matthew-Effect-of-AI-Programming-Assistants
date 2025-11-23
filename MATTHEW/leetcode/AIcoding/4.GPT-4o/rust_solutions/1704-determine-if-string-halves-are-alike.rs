impl Solution {
    pub fn halves_are_alike(s: String) -> bool {
        let (first_half, second_half) = s.split_at(s.len() / 2);
        let count_vowels = |s: &str| s.chars().filter(|&c| "aeiouAEIOU".contains(c)).count();
        count_vowels(first_half) == count_vowels(second_half)
    }
}