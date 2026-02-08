impl Solution {
    pub fn find_occurrence_of_first_almost_equal_substring(s: String, t: String, k: i32) -> i32 {
        let n = s.len();
        let m = t.len();

        if m > n {
            return -1;
        }

        let s_bytes = s.as_bytes();
        let t_bytes = t.as_bytes();

        for i in 0..=(n - m) {
            let mut diff_count = 0;
            for j in 0..m {
                if s_bytes[i + j] != t_bytes[j] {
                    diff_count += 1;
                }
                if diff_count > k {
                    break;
                }
            }
            if diff_count <= k {
                return i as i32;
            }
        }

        -1
    }
}