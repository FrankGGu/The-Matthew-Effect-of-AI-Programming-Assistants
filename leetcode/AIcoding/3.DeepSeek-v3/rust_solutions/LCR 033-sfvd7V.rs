use std::collections::HashMap;

impl Solution {
    pub fn group_anagrams(strs: Vec<String>) -> Vec<Vec<String>> {
        let mut map: HashMap<String, Vec<String>> = HashMap::new();

        for s in strs {
            let mut key = s.chars().collect::<Vec<char>>();
            key.sort_unstable();
            let key: String = key.into_iter().collect();
            map.entry(key).or_insert(Vec::new()).push(s);
        }

        map.into_values().collect()
    }
}