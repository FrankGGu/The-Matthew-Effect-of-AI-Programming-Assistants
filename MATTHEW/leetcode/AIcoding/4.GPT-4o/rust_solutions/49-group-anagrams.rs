use std::collections::HashMap;

pub fn group_anagrams(strs: Vec<String>) -> Vec<Vec<String>> {
    let mut anagrams: HashMap<String, Vec<String>> = HashMap::new();

    for s in strs {
        let mut chars = s.chars().collect::<Vec<_>>();
        chars.sort();
        let key = chars.iter().collect::<String>();
        anagrams.entry(key).or_default().push(s);
    }

    anagrams.into_values().collect()
}