impl Solution {
    pub fn base_neg2(mut n: i32) -> String {
        if n == 0 {
            return "0".to_string();
        }
        let mut res = Vec::new();
        while n != 0 {
            let rem = n % -2;
            n /= -2;
            if rem < 0 {
                n += 1;
                res.push((rem + 2).to_string());
            } else {
                res.push(rem.to_string());
            }
        }
        res.iter().rev().collect()
    }
}