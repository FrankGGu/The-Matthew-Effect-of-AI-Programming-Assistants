struct Solution;

impl Solution {
    pub fn max_length(arr: Vec<String>) -> i32 {
        let mut valid_items: Vec<(u32, i32)> = Vec::new();

        for s in arr {
            let mut mask = 0u32;
            let mut is_valid = true;
            for c in s.chars() {
                let bit = 1 << (c as u8 - b'a');
                if (mask & bit) != 0 {
                    is_valid = false;
                    break;
                }
                mask |= bit;
            }
            if is_valid {
                valid_items.push((mask, s.len() as i32));
            }
        }

        let mut max_len = 0;
        Self::backtrack(&valid_items, 0, 0, 0, &mut max_len);
        max_len
    }

    fn backtrack(
        valid_items: &Vec<(u32, i32)>,
        index: usize,
        current_mask: u32,
        current_length: i32,
        max_len: &mut i32,
    ) {
        *max_len = (*max_len).max(current_length);

        if index == valid_items.len() {
            return;
        }

        for i in index..valid_items.len() {
            let (item_mask, item_len) = valid_items[i];

            if (current_mask & item_mask) == 0 {
                Self::backtrack(
                    valid_items,
                    i + 1,
                    current_mask | item_mask,
                    current_length + item_len,
                    max_len,
                );
            }
        }
    }
}