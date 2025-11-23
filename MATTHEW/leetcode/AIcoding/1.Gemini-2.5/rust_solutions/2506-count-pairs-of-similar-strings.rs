impl Solution {
    pub fn count_similar_pairs(words: Vec<String>) -> i32 {
        let mut masks: Vec<u32> = Vec::with_capacity(words.len());

        for word in words.iter() {
            let mut mask: u32 = 0;
            for c in word.chars() {
                mask |= 1 << (c as u8 - b'a');
            }
            masks.push(mask);
        }

        let n = masks.len();
        let mut count: i32 = 0;

        for i in 0..n {
            for j in (i + 1)..n {
                if masks[i] == masks[j] {
                    count += 1;
                }
            }
        }

        count
    }
}