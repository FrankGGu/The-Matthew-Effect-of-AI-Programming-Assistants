impl Solution {
    pub fn can_be_typed_words(text: String, broken_letters: String) -> i32 {
        let broken: std::collections::HashSet<char> = broken_letters.chars().collect();
        let mut count = 0;
        for word in text.split_whitespace() {
            let mut possible = true;
            for c in word.chars() {
                if broken.contains(&c) {
                    possible = false;
                    break;
                }
            }
            if possible {
                count += 1;
            }
        }
        count
    }
}