impl Solution {
    pub fn max_product(words: Vec<String>) -> i32 {
        let masks: Vec<u32> = words
            .iter()
            .map(|word| {
                word.bytes().fold(0, |mask, c| mask | (1 << (c - b'a')))
            })
            .collect();

        let mut max = 0;
        for i in 0..words.len() {
            for j in i + 1..words.len() {
                if masks[i] & masks[j] == 0 {
                    max = max.max(words[i].len() * words[j].len());
                }
            }
        }
        max as i32
    }
}