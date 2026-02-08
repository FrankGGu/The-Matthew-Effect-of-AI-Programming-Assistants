impl Solution {
    pub fn find_the_longest_balanced_substring(s: String) -> i32 {
        let mut max_len = 0;
        let mut count = vec![0; 2];
        let bytes = s.as_bytes();

        for &c in bytes.iter() {
            if c == b'0' {
                if count[1] > 0 {
                    count[0] = 0;
                    count[1] = 0;
                }
                count[0] += 1;
            } else {
                count[1] += 1;
            }
            if count[0] >= count[1] && count[1] > 0 {
                max_len = max_len.max(2 * count[1]);
            }
        }
        max_len
    }
}