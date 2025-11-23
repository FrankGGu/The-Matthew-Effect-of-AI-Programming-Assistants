impl Solution {
    pub fn count_substrings(s: String, t: String) -> i32 {
        let (m, n) = (s.len(), t.len());
        let mut result = 0;

        for i in 0..m {
            for j in 0..n {
                let mut diff = 0;
                let mut k = 0;

                while i + k < m && j + k < n {
                    if s.as_bytes()[i + k] != t.as_bytes()[j + k] {
                        diff += 1;
                    }
                    if diff > 1 {
                        break;
                    }
                    result += diff;
                    k += 1;
                }
            }
        }
        result
    }
}