impl Solution {
    pub fn reverse_only_letters(s: String) -> String {
        let mut chars: Vec<char> = s.chars().collect();
        let mut left = 0;
        let mut right = chars.len() - 1;

        while left < right {
            while left < right && !chars[left].is_alphabetic() {
                left += 1;
            }
            while left < right && !chars[right].is_alphabetic() {
                right -= 1;
            }

            if left < right {
                chars.swap(left, right);
                left += 1;
                right -= 1;
            }
        }

        chars.into_iter().collect()
    }
}