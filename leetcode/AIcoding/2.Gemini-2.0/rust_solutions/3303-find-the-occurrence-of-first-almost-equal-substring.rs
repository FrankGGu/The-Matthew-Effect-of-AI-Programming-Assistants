impl Solution {
    pub fn find_first_almost_equal(s1: String, s2: String, difference: i32) -> i32 {
        let s1_bytes = s1.as_bytes();
        let s2_bytes = s2.as_bytes();
        let n = s1_bytes.len();
        let m = s2_bytes.len();
        if n < m {
            return -1;
        }

        for i in 0..=n - m {
            let mut diff_count = 0;
            for j in 0..m {
                if s1_bytes[i + j] != s2_bytes[j] {
                    diff_count += 1;
                }
            }
            if diff_count <= difference {
                return i as i32;
            }
        }

        -1
    }
}