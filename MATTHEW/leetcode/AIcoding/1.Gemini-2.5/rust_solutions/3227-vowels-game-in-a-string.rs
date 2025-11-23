impl Solution {
    pub fn vowels_game(s: String) -> bool {
        let vowels = ['a', 'e', 'i', 'o', 'u'];
        for c in s.chars() {
            if vowels.contains(&c) {
                return true;
            }
        }
        false
    }
}