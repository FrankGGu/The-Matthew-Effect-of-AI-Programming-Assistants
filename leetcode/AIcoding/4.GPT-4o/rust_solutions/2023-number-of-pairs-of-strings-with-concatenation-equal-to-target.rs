impl Solution {
    pub fn count_pairs(words: Vec<String>, target: String) -> i32 {
        let mut count = 0;
        let mut map = std::collections::HashMap::new();

        for word in &words {
            let needed = target.clone() + &word;
            count += map.get(&needed).unwrap_or(&0);
            let needed = word.clone() + &target;
            *map.entry(needed).or_insert(0) += 1;
        }

        count
    }
}