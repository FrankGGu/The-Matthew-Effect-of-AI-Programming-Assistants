fn pow_mod(mut base: i64, mut exp: i64, modulus: i64) -> i64 {
    let mut res = 1;
    base %= modulus;
    while exp > 0 {
        if exp % 2 == 1 {
            res = (res * base) % modulus;
        }
        base = (base * base) % modulus;
        exp /= 2;
    }
    res
}

fn mod_inverse(mut a: i64, mut m: i64) -> i64 {
    let m0 = m;
    let mut x0 = 0;
    let mut x1 = 1;

    if m == 1 {
        return 0;
    }

    while a > 1 {
        let q = a / m;
        let mut t = m;
        m = a % m;
        a = t;
        t = x0;
        x0 = x1 - q * x0;
        x1 = t;
    }

    if x1 < 0 {
        x1 += m0;
    }
    x1
}

fn count_factors(mut n: i64, factor: i64) -> i64 {
    let mut count = 0;
    while n > 0 {
        n /= factor;
        count += n;
    }
    count
}

fn log10_factorial(n: i64) -> f64 {
    if n == 0 {
        return 0.0;
    }
    if n <= 20 {
        let mut sum_log = 0.0;
        for i in 1..=n {
            sum_log += (i as f64).log10();
        }
        return sum_log;
    }

    let n_f = n as f64;
    let log_n = n_f.log10();

    const LOG10_E: f64 = 0.4342944819032518;
    const LOG10_2PI: f64 = 0.7981798683569035;

    n_f * log_n - n_f * LOG10_E + 0.5 * (LOG10_2PI + n_f.log10())
}

fn get_val_mod_pk(n: i64, p: i64, pk: i64) -> i64 {
    if n == 0 {
        return 1;
    }

    let mut res = 1;

    let mut cycle_prod = 1;
    for i in 1..pk {
        if i % p != 0 {
            cycle_prod = (cycle_prod * i) % pk;
        }
    }

    res = pow_mod(cycle_prod, n / pk, pk);

    for i in (n / pk * pk + 1)..=n {
        if i % p != 0 {
            res = (res * (i % pk)) % pk;
        }
    }

    res = (res * get_val_mod_pk(n / p, p, pk)) % pk;
    res
}

struct Solution;

impl Solution {
    pub fn abbreviate_product(left: i64, right: i64) -> String {
        let count_fives_right = count_factors(right, 5);
        let count_fives_left_minus_1 = count_factors(left - 1, 5);
        let count_twos_right = count_factors(right, 2);
        let count_twos_left_minus_1 = count_factors(left - 1, 2);

        let total_fives = count_fives_right - count_fives_left_minus_1;
        let total_twos = count_twos_right - count_twos_left_minus_1;
        let total_zeros = total_fives.min(total_twos);

        let log10_prod_right = log10_factorial(right);
        let log10_prod_left_minus_1 = log10_factorial(left - 1);
        let log10_prod = log10_prod_right - log10_prod_left_minus_1;

        let total_digits = log10_prod.floor() as i64 + 1;

        if total_digits <= 10 {
            let mut actual_product: u128 = 1;
            for i in left..=right {
                actual_product = actual_product.checked_mul(i as u128).unwrap();
            }
            return actual_product.to_string();
        }

        let fractional_part = log10_prod.fract();
        let first_five_digits_float = 10.0_f64.powf(fractional_part + 4.0);
        let first_five_digits = first_five_digits_float as i64;

        let mod2_val = 32;
        let mod5_val = 3125;

        let val_mod2_right = get_val_mod_pk(right, 5, mod2_val);
        let val_mod2_left_minus_1 = get_val_mod_pk(left - 1, 5, mod2_val);

        let mut p_prime_mod2 = (val_mod2_right * mod_inverse(val_mod2_left_minus_1, mod2_val)) % mod2_val;

        let remaining_twos = total_twos - total_zeros;
        if remaining_twos >= 5 {
            p_prime_mod2 = 0;
        } else {
            p_prime_mod2 = (p_prime_mod2 * pow_mod(2, remaining_twos, mod2_val)) % mod2_val;
        }

        let val_mod5_right = get_val_mod_pk(right, 2, mod5_val);
        let val_mod5_left_minus_1 = get_val_mod_pk(left - 1, 2, mod5_val);

        let mut p_prime_mod5 = (val_mod5_right * mod_inverse(val_mod5_left_minus_1, mod5_val)) % mod5_val;

        let remaining_fives = total_fives - total_zeros;
        if remaining_fives >= 5 {
            p_prime_mod5 = 0;
        } else {
            p_prime_mod5 = (p_prime_mod5 * pow_mod(5, remaining_fives, mod5_val)) % mod5_val;
        }

        let m1 = mod2_val;
        let m2 = mod5_val;
        let a1 = p_prime_mod2;
        let a2 = p_prime_mod5;

        let inv_m1_m2 = 293; 

        let k = (((a2 - a1 + m2) % m2) * inv_m1_m2) % m2;
        let last_five_digits_val = (a1 + k * m1) % (m1 * m2);

        let last_five_digits_string = format!("{:05}", last_five_digits_val);

        format!("{}...{}e{}", first_five_digits, last_five_digits_string, total_digits - total_zeros)
    }
}