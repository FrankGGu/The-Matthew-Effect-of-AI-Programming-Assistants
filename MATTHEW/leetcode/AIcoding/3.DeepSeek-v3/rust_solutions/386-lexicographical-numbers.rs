impl Solution {
    pub fn lexical_order(n: i32) -> Vec<i32> {
        let mut res = Vec::with_capacity(n as usize);
        let mut num = 1;
        for _ in 0..n {
            res.push(num);
            if num * 10 <= n {
                num *= 10;
            } else {
                while num % 10 == 9 || num + 1 > n {
                    num /= 10;
                }
                num += 1;
            }
        }
        res
    }
}