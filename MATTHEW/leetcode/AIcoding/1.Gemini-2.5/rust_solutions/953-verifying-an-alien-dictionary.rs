impl Solution {
    pub fn is_alien_sorted(words: Vec<String>, order: String) -> bool {
        let mut order_map = [0; 26];
        for (i, c) in order.chars().enumerate() {
            order_map[(c as u8 - b'a') as usize] = i as u8;
        }

        for i in 0..words.len() - 1 {
            let word1 = &words[i];
            let word2 = &words[i + 1];

            let mut compared_diff_char = false;
            for (c1, c2) in word1.chars().zip(word2.chars()) {
                let ord1 = order_map[(c1 as u8 - b'a') as usize];
                let ord2 = order_map[(c2 as u8 - b'a') as usize];

                if ord1 < ord2 {
                    compared_diff_char = true;
                    break;
                } else if ord1 > ord2 {
                    return false;
                }
            }

            if !compared_diff_char && word1.len() > word2.len() {
                return false;
            }
        }

        true
    }
}