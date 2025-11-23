impl Solution {
    pub fn closest_divisors(num: i32) -> Vec<i32> {
        let mut a = (num + 1) as i64;
        let mut b = (num + 2) as i64;
        let mut res_a = vec![1, a as i32];
        let mut res_b = vec![1, b as i32];

        let mut i = (a as f64).sqrt() as i64;
        while i > 0 {
            if a % i == 0 {
                res_a = vec![i as i32, (a / i) as i32];
                break;
            }
            i -= 1;
        }

        i = (b as f64).sqrt() as i64;
        while i > 0 {
            if b % i == 0 {
                res_b = vec![i as i32, (b / i) as i32];
                break;
            }
            i -= 1;
        }

        if (res_a[1] - res_a[0]).abs() <= (res_b[1] - res_b[0]).abs(){
            return res_a
        } else {
            return res_b
        }
    }
}