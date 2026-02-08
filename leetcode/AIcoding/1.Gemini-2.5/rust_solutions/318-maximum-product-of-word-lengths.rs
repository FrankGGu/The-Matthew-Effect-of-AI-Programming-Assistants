impl Solution {
    pub fn max_product(words: Vec<String>) -> i32 {
        let mut word_data: Vec<(u32, usize)> = Vec::with_capacity(words.len());

        for word in words {
            let mut mask = 0;
            for c in word.chars() {
                mask |= 1 << (c as u8 - b'a');
            }
            word_data.push((mask, word.len()));
        }

        let mut max_prod = 0;
        for i in 0..word_data.len() {
            for j in (i + 1)..word_data.len() {
                let (mask1, len1) = word_data[i];
                let (mask2, len2) = word_data[j];

                if (mask1 & mask2) == 0 {
                    max_prod = max_prod.max((len1 * len2) as i32);
                }
            }
        }

        max_prod
    }
}