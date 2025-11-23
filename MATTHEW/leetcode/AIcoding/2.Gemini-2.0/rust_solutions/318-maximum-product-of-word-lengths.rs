impl Solution {
    pub fn max_product(words: Vec<String>) -> i32 {
        let n = words.len();
        let mut masks = vec![0; n];

        for i in 0..n {
            for &c in words[i].as_bytes() {
                masks[i] |= 1 << (c - b'a');
            }
        }

        let mut max_prod = 0;
        for i in 0..n {
            for j in i + 1..n {
                if (masks[i] & masks[j]) == 0 {
                    max_prod = max_prod.max((words[i].len() * words[j].len()) as i32);
                }
            }
        }

        max_prod
    }
}