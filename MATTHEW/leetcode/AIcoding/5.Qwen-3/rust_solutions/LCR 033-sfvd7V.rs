impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn group_anagrams(strs: Vec<String>) -> Vec<Vec<String>> {
        let mut map = HashMap::new();

        for s in strs {
            let mut chars: Vec<char> = s.chars().collect();
            chars.sort();
            let key = chars.into_iter().collect::<String>();

            map.entry(key)
                .or_insert_with(Vec::new)
                .push(s);
        }

        map.into_values().collect()
    }
}
}