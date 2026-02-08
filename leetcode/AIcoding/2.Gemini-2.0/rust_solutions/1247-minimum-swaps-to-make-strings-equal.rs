impl Solution {
    pub fn minimum_swaps(s1: String, s2: String) -> i32 {
        let s1_bytes = s1.as_bytes();
        let s2_bytes = s2.as_bytes();
        let mut xy = 0;
        let mut yx = 0;
        for i in 0..s1_bytes.len() {
            if s1_bytes[i] != s2_bytes[i] {
                if s1_bytes[i] == b'x' {
                    xy += 1;
                } else {
                    yx += 1;
                }
            }
        }
        if (xy + yx) % 2 != 0 {
            return -1;
        }
        xy / 2 + yx / 2 + (xy % 2 + yx % 2)
    }
}