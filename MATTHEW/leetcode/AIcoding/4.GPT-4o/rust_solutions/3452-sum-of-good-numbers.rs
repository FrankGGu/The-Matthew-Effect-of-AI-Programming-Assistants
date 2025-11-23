impl Solution {
    pub fn sum_of_good_numbers(n: i32) -> i32 {
        const MOD: i32 = 1_000_000_007;
        let even_count = (n + 1) / 2;
        let odd_count = n / 2;
        let mut even_sum = 1;
        let mut odd_sum = 5;
        for _ in 1..even_count {
            even_sum = even_sum * 10 % MOD;
        }
        for _ in 0..odd_count {
            odd_sum = odd_sum * 10 % MOD;
        }
        (even_sum + odd_sum) % MOD
    }
}