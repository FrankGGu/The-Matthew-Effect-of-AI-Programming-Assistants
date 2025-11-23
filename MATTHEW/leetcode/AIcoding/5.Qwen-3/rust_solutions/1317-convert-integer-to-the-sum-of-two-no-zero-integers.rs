struct Solution;

impl Solution {
    pub fn get_no_zero_integers(n: i32) -> Vec<i32> {
        for a in 1..n {
            let b = n - a;
            if !has_zero(a) && !has_zero(b) {
                return vec![a, b];
            }
        }
        vec![]
    }

    fn has_zero(x: i32) -> bool {
        let mut num = x;
        while num > 0 {
            if num % 10 == 0 {
                return true;
            }
            num /= 10;
        }
        false
    }
}