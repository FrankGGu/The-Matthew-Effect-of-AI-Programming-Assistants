impl Solution {
    pub fn min_insertions(s: String) -> i32 {
        let mut res = 0;
        let mut right_needed = 0;

        for c in s.chars() {
            if c == '(' {
                if right_needed % 2 != 0 {
                    res += 1;
                    right_needed -= 1;
                }
                right_needed += 2;
            } else {
                if right_needed == 0 {
                    res += 1;
                    right_needed += 1;
                } else {
                    right_needed -= 1;
                }
            }
        }

        res + right_needed
    }
}