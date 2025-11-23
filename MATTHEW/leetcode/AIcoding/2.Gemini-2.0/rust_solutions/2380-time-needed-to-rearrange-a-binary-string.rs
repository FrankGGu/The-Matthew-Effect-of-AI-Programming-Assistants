impl Solution {
    pub fn seconds_to_rearrange(s: String) -> i32 {
        let mut s = s.chars().collect::<Vec<_>>();
        let mut seconds = 0;
        let mut swapped = true;
        while swapped {
            swapped = false;
            for i in 0..s.len() - 1 {
                if s[i] == '0' && s[i + 1] == '1' {
                    s.swap(i, i + 1);
                    swapped = true;
                }
            }
            if swapped {
                seconds += 1;
            }
        }
        seconds
    }
}