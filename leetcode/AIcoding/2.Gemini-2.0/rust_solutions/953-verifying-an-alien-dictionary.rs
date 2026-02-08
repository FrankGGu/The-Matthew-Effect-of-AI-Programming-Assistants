impl Solution {
    pub fn is_alien_sorted(words: Vec<String>, order: String) -> bool {
        let mut order_map = std::collections::HashMap::new();
        for (i, c) in order.chars().enumerate() {
            order_map.insert(c, i as i32);
        }

        for i in 0..words.len() - 1 {
            let word1 = words[i].chars().collect::<Vec<char>>();
            let word2 = words[i + 1].chars().collect::<Vec<char>>();

            let mut j = 0;
            while j < word1.len() && j < word2.len() {
                let char1 = word1[j];
                let char2 = word2[j];

                let order1 = order_map[&char1];
                let order2 = order_map[&char2];

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