use std::collections::HashMap;

impl Solution {
    pub fn odd_string(words: Vec<String>) -> String {
        let mut map: HashMap<Vec<i32>, Vec<String>> = HashMap::new();

        for word in words {
            let mut diff = Vec::new();
            let chars: Vec<char> = word.chars().collect();
            for i in 1..chars.len() {
                diff.push((chars[i] as i32) - (chars[i - 1] as i32));
            }
            map.entry(diff).or_default().push(word);
        }

        for (_, v) in map {
            if v.len() == 1 {
                return v[0].clone();
            }
        }

        String::new()
    }
}