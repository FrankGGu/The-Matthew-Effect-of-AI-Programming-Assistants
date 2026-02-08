impl Solution {
    pub fn divisibility_array(word: String, m: i32) -> Vec<i32> {
        let mut rem: i64 = 0;
        let mut res: Vec<i32> = Vec::new();
        for c in word.chars() {
            rem = (rem * 10 + (c as i64 - '0' as i64)) % (m as i64);
            if rem == 0 {
                res.push(1);
            } else {
                res.push(0);
            }
        }
        res
    }
}