impl Solution {
    pub fn is_alien_sorted(words: Vec<String>, order: String) -> bool {
        if words.len() <= 1 {
            return true;
        }

        let mut order_map = [0; 26];
        for (i, c) in order.chars().enumerate() {
            order_map[(c as u8 - b'a') as usize] = i;
        }

        for i in 0..words.len() - 1 {
            let s1 = words[i].as_bytes();
            let s2 = words[i+1].as_bytes();

            let mut is_current_pair_sorted = false;
            let max_len = s1.len().min(s2.len());

            for j in 0..max_len {
                let char_idx1 = (s1[j] - b'a') as usize;
                let char_idx2 = (s2[j] - b'a') as usize;

                let ord1 = order_map[char_idx1];
                let ord2 = order_map[char_idx2];

                if ord1 < ord2 {
                    is_current_pair_sorted = true;
                    break;
                } else if ord1 > ord2 {
                    return false;
                }
            }

            if !is_current_pair_sorted && s1.len() > s2.len() {
                return false;
            }
        }

        true
    }
}