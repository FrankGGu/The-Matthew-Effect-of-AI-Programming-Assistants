impl Solution {
    pub fn min_operations(s: String) -> i32 {
        let n = s.len();
        let s_bytes = s.as_bytes();
        let mut count0 = 0;
        let mut count1 = 0;

        for i in 0..n {
            if (i % 2 == 0 && s_bytes[i] != b'0') || (i % 2 != 0 && s_bytes[i] != b'1') {
                count0 += 1;
            }

            if (i % 2 == 0 && s_bytes[i] != b'1') || (i % 2 != 0 && s_bytes[i] != b'0') {
                count1 += 1;
            }
        }

        count0.min(count1)
    }
}