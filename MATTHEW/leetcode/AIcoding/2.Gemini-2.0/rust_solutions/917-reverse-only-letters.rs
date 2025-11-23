impl Solution {
    pub fn reverse_only_letters(s: String) -> String {
        let mut chars: Vec<char> = s.chars().collect();
        let mut i = 0;
        let mut j = chars.len() - 1;

        while i < j {
            while i < j && !chars[i].is_alphabetic() {
                i += 1;
            }
            while i < j && !chars[j].is_alphabetic() {
                j -= 1;
            }

            if i < j {
                chars.swap(i, j);
                i += 1;
                j -= 1;
            }
        }

        chars.into_iter().collect()
    }
}