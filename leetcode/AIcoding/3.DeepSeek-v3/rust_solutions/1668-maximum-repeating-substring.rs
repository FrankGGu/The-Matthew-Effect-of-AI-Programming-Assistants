impl Solution {
    pub fn max_repeating(sequence: String, word: String) -> i32 {
        let seq = sequence.as_bytes();
        let w = word.as_bytes();
        let n = seq.len();
        let m = w.len();
        if m > n {
            return 0;
        }
        let mut max_k = 0;
        for i in 0..=n - m {
            let mut k = 0;
            let mut j = i;
            while j + m <= n && &seq[j..j + m] == w {
                k += 1;
                j += m;
            }
            max_k = max_k.max(k);
        }
        max_k
    }
}