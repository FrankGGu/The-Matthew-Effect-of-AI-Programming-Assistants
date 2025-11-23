impl Solution {
    pub fn get_good_indices(variables: Vec<Vec<i32>>, target: i32) -> Vec<i32> {
        let mut result: Vec<i32> = Vec::new();
        for i in 0..variables.len() {
            let a = variables[i][0];
            let b = variables[i][1];
            let c = variables[i][2];
            let m = variables[i][3];

            let val = Self::power(a, b, 10) % 10;
            let val2 = Self::power(val, c, m);

            if val2 == target {
                result.push(i as i32);
            }
        }
        return result;
    }

    fn power(base: i32, exp: i32, modulus: i32) -> i32 {
        let mut res: i64 = 1;
        let mut base_long: i64 = base as i64;
        let mut exp_long: i64 = exp as i64;
        let modulus_long: i64 = modulus as i64;

        while exp_long > 0 {
            if exp_long % 2 == 1 {
                res = (res * base_long) % modulus_long;
            }
            base_long = (base_long * base_long) % modulus_long;
            exp_long /= 2;
        }

        res as i32
    }
}