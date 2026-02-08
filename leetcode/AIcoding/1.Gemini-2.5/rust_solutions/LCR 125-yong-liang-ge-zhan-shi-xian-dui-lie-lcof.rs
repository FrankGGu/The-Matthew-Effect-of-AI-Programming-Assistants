impl Solution {
    pub fn can_construct(s: String, k: i32) -> bool {
        let n = s.len();
        let k_usize = k as usize;

        if k_usize > n {
            return false;
        }

        let mut counts = [0; 26];
        for c in s.bytes() {
            counts[(c - b'a') as usize] += 1;
        }

        let mut odd_freq_chars = 0;
        for &count in counts.iter() {
            if count % 2 != 0 {
                odd_freq_chars += 1;
            }
        }

        odd_freq_chars <= k_usize
    }
}