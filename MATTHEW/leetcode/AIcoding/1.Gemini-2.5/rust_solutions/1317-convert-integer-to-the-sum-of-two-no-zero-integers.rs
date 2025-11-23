impl Solution {
    pub fn get_no_zero_integers(n: i32) -> Vec<i32> {
        fn contains_zero(mut num: i32) -> bool {
            if num == 0 {
                return true;
            }
            while num > 0 {
                if num % 10 == 0 {
                    return true;
                }
                num /= 10;
            }
            false
        }

        for a in 1..n {
            let b = n - a;
            if !contains_zero(a) && !contains_zero(b) {
                return vec![a, b];
            }
        }
        unreachable!()
    }
}