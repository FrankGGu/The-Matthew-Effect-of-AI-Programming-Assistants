impl Solution {
    pub fn wonderful_substrings(word: String) -> i64 {
        let mut count = 0;
        let mut freq = vec![0; 1024];
        freq[0] = 1;

        let mut mask = 0;
        for c in word.chars() {
            let digit = (c as u8 - b'a') as usize;
            mask ^= 1 << digit;

            count += freq[mask];

            for i in 0..10 {
                count += freq[mask ^ (1 << i)];
            }

            freq[mask] += 1;
        }

        count
    }
}