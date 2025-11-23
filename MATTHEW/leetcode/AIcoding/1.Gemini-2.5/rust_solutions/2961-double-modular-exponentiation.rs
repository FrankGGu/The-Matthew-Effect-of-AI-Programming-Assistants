impl Solution {
    fn pow_mod(mut base: i32, mut exp: i32, modulus: i32) -> i32 {
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

    pub fn get_good_indices(variables: Vec<Vec<i32>>, target: i32) -> Vec<i32> {
        let mut good_indices = Vec::new();
        for (i, var) in variables.iter().enumerate() {
            let a = var[0];
            let b = var[1];
            let c = var[2];
            let m = var[3];

            let term1 = Solution::pow_mod(a, b, 10);
            let final_result = Solution::pow_mod(term1, c, m);

            if final_result == target {
                good_indices.push(i as i32);
            }
        }
        good_indices
    }
}