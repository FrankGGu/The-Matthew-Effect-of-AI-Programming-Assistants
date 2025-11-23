impl Solution {
    pub fn max_length(arr: Vec<String>) -> i32 {
        let mut max_len = 0;
        let mut unique = vec![0];

        for s in arr {
            let mut mask = 0;
            let mut is_valid = true;
            for c in s.chars() {
                let bit = 1 << (c as u8 - b'a');
                if (mask & bit) != 0 {
                    is_valid = false;
                    break;
                }
                mask |= bit;
            }
            if !is_valid {
                continue;
            }

            let current_len = unique.len();
            for i in 0..current_len {
                if (unique[i] & mask) == 0 {
                    let new_mask = unique[i] | mask;
                    unique.push(new_mask);
                    max_len = std::cmp::max(max_len, (new_mask.count_ones()) as i32);
                }
            }
        }

        max_len
    }
}