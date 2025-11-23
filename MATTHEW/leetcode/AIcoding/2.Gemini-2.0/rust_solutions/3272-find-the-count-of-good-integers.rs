impl Solution {
    pub fn count_good_numbers(n: i32) -> i32 {
        let mut even_count = n / 2 + n % 2;
        let mut odd_count = n / 2;

        let mut ans = 1i64;
        let mut five = 5i64;
        let mut two = 4i64;
        let modulo = 1_000_000_007i64;

        while even_count > 0 {
            if even_count % 2 == 1 {
                ans = (ans * five) % modulo;
            }
            five = (five * five) % modulo;
            even_count /= 2;
        }

        while odd_count > 0 {
            if odd_count % 2 == 1 {
                ans = (ans * two) % modulo;
            }
            two = (two * two) % modulo;
            odd_count /= 2;
        }

        ans as i32
    }
}