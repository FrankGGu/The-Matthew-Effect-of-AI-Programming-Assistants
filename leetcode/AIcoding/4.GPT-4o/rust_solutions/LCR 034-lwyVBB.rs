pub fn is_alien_sorted(words: Vec<String>, order: String) -> bool {
    let mut order_map = std::collections::HashMap::new();
    for (i, c) in order.chars().enumerate() {
        order_map.insert(c, i);
    }

    for i in 0..words.len() - 1 {
        let word1 = &words[i];
        let word2 = &words[i + 1];
        let min_length = std::cmp::min(word1.len(), word2.len());

        for j in 0..min_length {
            if word1.chars().nth(j) != word2.chars().nth(j) {
                if order_map[&word1.chars().nth(j).unwrap()] > order_map[&word2.chars().nth(j).unwrap()] {
                    return false;
                }
                break;
            }
        }

        if word1.len() > word2.len() && word1.starts_with(&word2[..min_length]) {
            return false;
        }
    }

    true
}