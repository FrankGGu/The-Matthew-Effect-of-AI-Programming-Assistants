impl Solution {
    pub fn seconds_to_remove_occurrences(s: String) -> i32 {
        let mut s = s.into_bytes();
        let mut seconds = 0;
        loop {
            let mut changed = false;
            let mut i = 0;
            while i < s.len() - 1 {
                if s[i] == b'0' && s[i + 1] == b'1' {
                    s.swap(i, i + 1);
                    changed = true;
                    i += 1;
                }
                i += 1;
            }
            if !changed {
                break;
            }
            seconds += 1;
        }
        seconds
    }
}