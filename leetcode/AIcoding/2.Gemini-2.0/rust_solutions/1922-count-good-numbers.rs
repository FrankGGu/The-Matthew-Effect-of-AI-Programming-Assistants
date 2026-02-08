impl Solution {
    pub fn count_good_numbers(n: i32) -> i32 {
        let modulo: i64 = 1_000_000_007;
        let n = n as i64;

        let mut even_digits = (n + 1) / 2;
        let mut odd_digits = n / 2;

        let mut power_5 = 1;
        let mut base_5 = 5;
        while even_digits > 0 {
            if even_digits % 2 == 1 {
                power_5 = (power_5 * base_5) % modulo;
            }
            base_5 = (base_5 * base_5) % modulo;
            even_digits /= 2;
        }

        let mut power_4 = 1;
        let mut base_4 = 4;
        while odd_digits > 0 {
            if odd_digits % 2 == 1 {
                power_4 = (power_4 * base_4) % modulo;
            }
            base_4 = (base_4 * base_4) % modulo;
            odd_digits /= 2;
        }

        ((power_5 * power_4) % modulo) as i32
    }
}