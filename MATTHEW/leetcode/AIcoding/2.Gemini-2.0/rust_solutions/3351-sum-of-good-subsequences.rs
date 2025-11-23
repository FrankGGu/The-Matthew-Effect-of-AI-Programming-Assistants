impl Solution {
    pub fn sum_of_good_subsequences(nums: Vec<i32>) -> i32 {
        let mod_val = 1_000_000_007;
        let mut count = 0;
        let mut has_zero = false;

        for &num in &nums {
            if num == 0 {
                has_zero = true;
            } else {
                count += 1;
            }
        }

        let mut result = 0;
        if count > 0 {
            result = Self::power(2, count as i64, mod_val);
        }

        if has_zero {
            result = (result + mod_val - 1) % mod_val;
        }

        result
    }

    fn power(base: i64, exp: i64, mod_val: i32) -> i32 {
        let mut res = 1;
        let mut b = base % mod_val as i64;
        let mut e = exp;

        while e > 0 {
            if e % 2 == 1 {
                res = (res * b) % mod_val as i64;
            }
            b = (b * b) % mod_val as i64;
            e /= 2;
        }

        res as i32
    }
}