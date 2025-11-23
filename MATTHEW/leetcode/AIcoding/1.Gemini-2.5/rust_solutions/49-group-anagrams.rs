use std::collections::HashMap;

impl Solution {
    pub fn group_anagrams(strs: Vec<String>) -> Vec<Vec<String>> {
        let mut map: HashMap<String, Vec<String>> = HashMap::new();

        for s in strs {
            let mut chars: Vec<char> = s.chars().collect();
            chars.sort_unstable();
            let sorted_s: String = chars.into_iter().collect();
            map.entry(sorted_s).or_insert_with(Vec::new).push(s);
        }

        map.into_values().collect()
    }
}