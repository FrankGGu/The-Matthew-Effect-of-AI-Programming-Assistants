impl Solution {
    pub fn is_alien_sorted(words: Vec<String>, order: String) -> bool {
        let mut order_map = std::collections::HashMap::new();
        for (i, c) in order.chars().enumerate() {
            order_map.insert(c, i as i32);
        }

        for i in 0..words.len() - 1 {
            let word1 = words[i].as_bytes();
            let word2 = words[i + 1].as_bytes();
            let mut j = 0;
            while j < word1.len() && j < word2.len() {
                let char1 = word1[j] as char;
                let char2 = word2[j] as char;
                let order1 = order_map.get(&char1).unwrap();
                let order2 = order_map.get(&char2).unwrap();
                if order1 < order2 {
                    break;
                } else if order1 > order2 {
                    return false;
                }
                j += 1;
            }
            if j == word2.len() && j < word1.len() {
                return false;
            }
        }

        true
    }
}