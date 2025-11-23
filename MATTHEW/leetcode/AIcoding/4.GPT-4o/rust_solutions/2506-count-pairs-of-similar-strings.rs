impl Solution {
    pub fn similar_pairs(words: Vec<String>) -> i32 {
        let mut count = 0;
        let mut seen = std::collections::HashSet::new();

        for word in &words {
            let mut chars = word.chars().collect::<std::collections::HashSet<_>>();
            let mut key = chars.iter().collect::<Vec<_>>();
            key.sort();
            seen.insert(key);
        }

        for word in &words {
            let mut chars = word.chars().collect::<std::collections::HashSet<_>>();
            let mut key = chars.iter().collect::<Vec<_>>();
            key.sort();
            count += seen.iter().filter(|&&k| k == key).count() as i32 - 1;
        }

        count / 2
    }
}