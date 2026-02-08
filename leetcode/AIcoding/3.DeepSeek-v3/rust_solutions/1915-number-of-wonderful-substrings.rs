impl Solution {
    pub fn wonderful_substrings(word: String) -> i64 {
        let mut count = 0;
        let mut prefix = 0;
        let mut freq = vec![0; 1024];
        freq[0] = 1;

        for c in word.chars() {
            let shift = (c as u8 - b'a') as usize;
            prefix ^= 1 << shift;
            count += freq[prefix];
            for i in 0..10 {
                count += freq[prefix ^ (1 << i)];
            }
            freq[prefix] += 1;
        }

        count
    }
}