impl Solution {
    pub fn reverse_prefix(word: String, ch: char) -> String {
        if let Some(idx) = word.find(ch) {
            let mut chars: Vec<char> = word.chars().collect();

            let mut left = 0;
            let mut right = idx;
            while left < right {
                chars.swap(left, right);
                left += 1;
                right -= 1;
            }

            chars.into_iter().collect()
        } else {
            word
        }
    }
}