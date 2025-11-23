impl Solution {
    pub fn count_substrings(s: String, k: i32) -> i32 {
        let n = s.len();
        let s_bytes = s.as_bytes();
        let mut count = 0;

        for i in 0..n {
            for j in i..n {
                let sub = &s_bytes[i..=j];
                let mut freq = [0; 26];
                for &c in sub {
                    freq[(c - b'a') as usize] += 1;
                }
                let mut k_count = 0;
                for &f in &freq {
                    if f == k {
                        k_count += 1;
                    }
                }
                if k_count > 0 {
                    count += 1;
                }
            }
        }

        count
    }
}