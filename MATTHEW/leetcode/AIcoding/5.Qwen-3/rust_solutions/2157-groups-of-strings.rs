impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn group_strings(mut strings: Vec<String>) -> Vec<Vec<String>> {
        let mut groups: HashMap<String, Vec<String>> = HashMap::new();

        for s in &mut strings {
            let key = Self::get_key(s);
            groups.entry(key).or_insert_with(Vec::new).push(s.clone());
        }

        groups.into_values().collect()
    }

    fn get_key(s: &str) -> String {
        let mut key = String::new();
        let chars: Vec<char> = s.chars().collect();

        for i in 1..chars.len() {
            let diff = (chars[i] as u8 - chars[i - 1] as u8 + 26) % 26;
            key.push(format!("{}", diff).as_str());
            key.push(',');
        }

        key
    }
}
}