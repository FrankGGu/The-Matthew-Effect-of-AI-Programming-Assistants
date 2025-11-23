use std::collections::HashMap;

pub fn group_anagrams(strs: Vec<String>) -> Vec<Vec<String>> {
    let mut map: HashMap<Vec<u8>, Vec<String>> = HashMap::new();

    for s in strs {
        let mut key = s.clone().into_bytes();
        key.sort();
        map.entry(key).or_insert(Vec::new()).push(s);
    }

    map.into_values().collect()
}