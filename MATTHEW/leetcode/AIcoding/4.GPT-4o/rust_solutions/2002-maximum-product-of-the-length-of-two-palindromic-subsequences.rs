impl Solution {
    pub fn max_product(words: Vec<String>) -> i32 {
        let n = words.len();
        let mut masks = vec![0; n];

        for (i, word) in words.iter().enumerate() {
            for c in word.chars() {
                masks[i] |= 1 << (c as u8 - b'a');
            }
        }

        let mut max_product = 0;

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