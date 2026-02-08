impl Solution {
    pub fn can_reach(s: String, min_jump: i32, max_jump: i32) -> bool {
        let n = s.len();
        let s_bytes = s.as_bytes();
        if s_bytes[n - 1] != b'0' {
            return false;
        }

        let mut reachable = vec![false; n];
        reachable[0] = true;
        let mut count = 0;

        for i in 0..n {
            if reachable[i] {
                let start = (i as i32 + min_jump) as usize;
                let end = std::cmp::min((i as i32 + max_jump) as usize + 1, n);

                for j in start..end {
                    if s_bytes[j] == b'0' && !reachable[j] {
                        reachable[j] = true;
                        count += 1;
                    }
                }
            }
        }

        reachable[n - 1]
    }
}