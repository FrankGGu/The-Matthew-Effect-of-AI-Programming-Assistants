impl Solution {
    pub fn wonderful_substrings(word: String) -> i64 {
        let mut count = vec![0; 1024];
        let mut mask = 0;
        let mut result = 0;

        count[0] = 1;

        for c in word.chars() {
            mask ^= 1 << (c as u8 - b'a');
            result += count[mask];
            for i in 0..10 {
                result += count[mask ^ (1 << i)];
            }
            count[mask] += 1;
        }

        result
    }
}