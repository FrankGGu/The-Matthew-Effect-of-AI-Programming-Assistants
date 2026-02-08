impl Solution {
    pub fn di_string_match(s: String) -> Vec<i32> {
        let mut res = Vec::with_capacity(s.len() + 1);
        let (mut low, mut high) = (0, s.len() as i32);
        for c in s.chars() {
            if c == 'I' {
                res.push(low);
                low += 1;
            } else {
                res.push(high);
                high -= 1;
            }
        }
        res.push(low);
        res
    }
}