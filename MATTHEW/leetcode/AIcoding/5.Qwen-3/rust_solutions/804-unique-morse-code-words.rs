impl Solution {

use std::collections::HashSet;

struct Solution {}

impl Solution {
    pub fn unique_morse_representations(words: Vec<&str>) -> i32 {
        let morse_codes = vec![".-", "-...", "-.-.", "-..", ".", "..-.", "--.", "....", ".", ".---", "-.-", ".--", "-", "-..", "---", ".--.", "--.-", ".-.", "...", "-", "..-", "...-", ".--", "-..-", "-.--", "--.."];
        let mut set = HashSet::new();

        for word in words {
            let mut code = String::new();
            for c in word.chars() {
                let index = (c as u8 - b'a') as usize;
                code.push_str(morse_codes[index]);
            }
            set.insert(code);
        }

        set.len() as i32
    }
}
}