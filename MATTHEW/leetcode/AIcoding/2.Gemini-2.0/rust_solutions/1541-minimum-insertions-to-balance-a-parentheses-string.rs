impl Solution {
    pub fn min_insertions(s: String) -> i32 {
        let mut ans = 0;
        let mut open = 0;
        for c in s.chars() {
            if c == '(' {
                if open > 0 {
                    open -= 1;
                    ans += 1;
                }
                open += 2;
            } else {
                if open > 0 {
                    open -= 1;
                } else {
                    ans += 1;
                }
                if open == 0 {
                    ans += 1;
                }
            }
        }
        ans += open;
        ans
    }
}