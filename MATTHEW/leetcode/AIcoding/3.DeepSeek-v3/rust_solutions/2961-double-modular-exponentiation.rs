impl Solution {
    pub fn get_good_indices(variables: Vec<Vec<i32>>, target: i32) -> Vec<i32> {
        let mut res = Vec::new();
        for (i, v) in variables.iter().enumerate() {
            let (a, b, c, m) = (v[0], v[1], v[2], v[3]);
            let first = Self::pow_mod(a, b, 10);
            let second = Self::pow_mod(first, c, m);
            if second == target {
                res.push(i as i32);
            }
        }
        res
    }

    fn pow_mod(mut base: i32, mut exp: i32, modulus: i32) -> i32 {
        if modulus == 1 {
            return 0;
        }
        let mut res = 1;
        base %= modulus;
        while exp > 0 {
            if exp % 2 == 1 {
                res = (res as i64 * base as i64 % modulus as i64) as i32;
            }
            base = (base as i64 * base as i64 % modulus as i64) as i32;
            exp /= 2;
        }
        res
    }
}