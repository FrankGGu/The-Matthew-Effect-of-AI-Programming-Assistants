impl Solution {

use std::collections::HashSet;

struct Solution {}

impl Solution {
    pub fn find_keyboard_row(words: Vec<String>) -> Vec<String> {
        let row1 = "qwertyuiop".chars().collect::<HashSet<_>>();
        let row2 = "asdfghjkl".chars().collect::<HashSet<_>>();
        let row3 = "zxcvbnm".chars().collect::<HashSet<_>>();

        words.into_iter()
            .filter(|word| {
                let chars: HashSet<_> = word.chars().collect();
                chars.is_subset(&row1) || chars.is_subset(&row2) || chars.is_subset(&row3)
            })
            .collect()
    }
}
}