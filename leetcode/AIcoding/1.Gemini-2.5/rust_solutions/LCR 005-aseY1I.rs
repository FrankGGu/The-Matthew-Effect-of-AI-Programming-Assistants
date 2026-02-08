impl Solution {
    pub fn max_product(words: Vec<String>) -> i32 {
        let n = words.len();
        if n < 2 {
            return 0;
        }

        let mut masks: Vec<i32> = Vec::with_capacity(n);
        let mut lengths: Vec<i32> = Vec::with_capacity(n);

        for word in words.iter() {
            let mut mask = 0;
            for c in word.chars() {
                mask |= 1 << ((c as u8) - b'a');
            }
            masks.push(mask);
            lengths.push(word.len() as i32);
        }

        let mut max_prod = 0;

        for i in 0..n {
            for j in (i + 1)..n {
                if (masks[i] & masks[j]) == 0 {
                    max_prod = max_prod.max(lengths[i] * lengths[j]);
                }
            }
        }

        max_prod
    }
}