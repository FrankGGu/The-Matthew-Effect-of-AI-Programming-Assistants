struct Solution;

impl Solution {
    pub fn navigate_device(n: i32, m: i32, k: i32, a: i32, b: i32) -> i32 {
        let mut res = 0;
        for i in 0..n {
            for j in 0..m {
                let x = i * k + a;
                let y = j * k + b;
                res += x * y;
            }
        }
        res
    }
}