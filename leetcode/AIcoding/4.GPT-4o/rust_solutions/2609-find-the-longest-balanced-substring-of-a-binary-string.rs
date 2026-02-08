impl Solution {
    pub fn find_the_longest_balanced_substring(s: String) -> i32 {
        let bytes = s.as_bytes();
        let mut max_len = 0;
        let mut count_0 = 0;
        let mut count_1 = 0;

        for &b in bytes {
            if b == b'0' {
                count_0 += 1;
            } else {
                count_1 += 1;
            }
            if count_0 == count_1 {
                max_len = max_len.max(count_0 * 2);
            }
        }

        count_0 = 0;
        count_1 = 0;
        for &b in bytes.iter().rev() {
            if b == b'0' {
                count_0 += 1;
            } else {
                count_1 += 1;
            }
            if count_0 == count_1 {
                max_len = max_len.max(count_0 * 2);
            }
        }

        max_len
    }
}