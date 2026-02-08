impl Solution {
    pub fn string_count(n: i32) -> i64 {
        let n = n as i64;
        let mod_val = 1_000_000_007;
        let total = mod_pow(26, n, mod_val);
        let no_l = mod_pow(25, n, mod_val);
        let no_t = no_l;
        let no_e = no_l;
        let no_l_no_t = mod_pow(24, n, mod_val);
        let no_l_no_e = no_l_no_t;
        let no_t_no_e = no_l_no_t;
        let no_l_no_t_no_e = mod_pow(23, n, mod_val);

        let mut res = total;
        res = (res - no_l + mod_val) % mod_val;
        res = (res - no_t + mod_val) % mod_val;
        res = (res - no_e + mod_val) % mod_val;
        res = (res + no_l_no_t) % mod_val;
        res = (res + no_l_no_e) % mod_val;
        res = (res + no_t_no_e) % mod_val;
        res = (res - no_l_no_t_no_e + mod_val) % mod_val;

        res
    }
}

fn mod_pow(mut base: i64, mut exp: i64, modulus: i64) -> i64 {
    if modulus == 1 {
        return 0;
    }
    let mut result = 1;
    base = base % modulus;
    while exp > 0 {
        if exp % 2 == 1 {
            result = result * base % modulus;
        }
        exp = exp >> 1;
        base = base * base % modulus;
    }
    result
}