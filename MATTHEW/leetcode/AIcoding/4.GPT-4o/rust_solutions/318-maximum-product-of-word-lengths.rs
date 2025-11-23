impl Solution {
    pub fn max_product(words: Vec<String>) -> i32 {
        let mut masks = Vec::new();
        for word in &words {
            let mut mask = 0;
            for c in word.chars() {
                mask |= 1 << (c as u8 - b'a');
            }
            masks.push(mask);
        }

        let mut max_product = 0;
        let n = words.len();
        for i in 0..n {
            for j in i + 1..n {
                if masks[i] & masks[j] == 0 {
                    max_product = max_product.max(words[i].len() * words[j].len() as i32);
                }
            }
        }
        max_product
    }
}