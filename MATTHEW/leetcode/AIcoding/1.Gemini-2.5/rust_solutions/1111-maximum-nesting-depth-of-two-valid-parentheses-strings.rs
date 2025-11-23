impl Solution {
    pub fn max_depth_after_split(s: String) -> Vec<i32> {
        let mut ans = Vec::with_capacity(s.len());
        let mut depth = 0;
        for c in s.chars() {
            if c == '(' {
                ans.push((depth % 2) as i32);
                depth += 1;
            } else { // c == ')'
                depth -= 1;
                ans.push((depth % 2) as i32);
            }
        }
        ans
    }
}