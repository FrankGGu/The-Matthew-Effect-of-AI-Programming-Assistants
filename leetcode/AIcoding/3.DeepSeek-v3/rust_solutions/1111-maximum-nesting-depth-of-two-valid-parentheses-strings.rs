impl Solution {
    pub fn max_depth_after_split(seq: String) -> Vec<i32> {
        let mut res = Vec::with_capacity(seq.len());
        let mut depth = 0;
        for c in seq.chars() {
            if c == '(' {
                depth += 1;
                res.push(depth % 2);
            } else {
                res.push(depth % 2);
                depth -= 1;
            }
        }
        res
    }
}