impl Solution {
    pub fn divisibility_array(word: String, m: i32) -> Vec<i32> {
        let mut res = Vec::new();
        let mut num: i64 = 0;
        let m = m as i64;
        for c in word.chars() {
            let digit = c.to_digit(10).unwrap() as i64;
            num = (num * 10 + digit) % m;
            res.push(if num == 0 { 1 } else { 0 });
        }
        res
    }
}