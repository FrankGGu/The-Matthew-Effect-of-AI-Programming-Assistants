impl Solution {
    pub fn is_alien_sorted(words: Vec<String>, order: String) -> bool {
        let mut order_map = std::collections::HashMap::new();
        for (i, c) in order.chars().enumerate() {
            order_map.insert(c, i);
        }

        let mut prev_word = String::new();
        for word in words {
            if !Self::in_order(&prev_word, &word, &order_map) {
                return false;
            }
            prev_word = word;
        }
        true
    }

    fn in_order(prev: &String, curr: &String, order_map: &std::collections::HashMap<char, usize>) -> bool {
        let min_len = std::cmp::min(prev.len(), curr.len());
        for i in 0..min_len {
            let prev_char = prev.chars().nth(i).unwrap();
            let curr_char = curr.chars().nth(i).unwrap();
            if prev_char != curr_char {
                return order_map[&curr_char] > order_map[&prev_char];
            }
        }
        prev.len() <= curr.len()
    }
}