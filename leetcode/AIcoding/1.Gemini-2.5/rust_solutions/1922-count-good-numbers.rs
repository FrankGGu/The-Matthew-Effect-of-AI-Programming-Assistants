struct Solution;

impl Solution {
    fn power(mut base: i64, mut exp: i64, modulus: i64) -> i64 {
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

    pub fn count_good_numbers(n: i64) -> i32 {
        let modulus: i64 = 1_000_000_007;

        let num_even_positions = (n + 1) / 2;
        let num_odd_positions = n / 2;

        let ans_even_pos_choices = Self::power(5, num_even_positions, modulus);
        let ans_odd_pos_choices = Self::power(4, num_odd_positions, modulus);

        ((ans_even_pos_choices * ans_odd_pos_choices) % modulus) as i32
    }
}