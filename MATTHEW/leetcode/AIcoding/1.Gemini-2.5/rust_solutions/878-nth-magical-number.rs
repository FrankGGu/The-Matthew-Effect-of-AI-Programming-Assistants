impl Solution {
    pub fn nth_magical_number(n: i32, a: i32, b: i32) -> i32 {
        let n_long = n as i64;
        let a_long = a as i64;
        let b_long = b as i64;

        let common_lcm = Self::lcm(a_long, b_long);

        let mut low = 1_i64;
        let mut high = n_long * std::cmp::max(a_long, b_long);
        let mut ans = high;

        let modulo = 1_000_000_007_i64;

        while low <= high {
            let mid = low + (high - low) / 2;
            let count = Self::count_magical(mid, a_long, b_long, common_lcm);

            if count >= n_long {
                ans = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }

        (ans % modulo) as i32
    }

    fn gcd(mut a: i64, mut b: i64) -> i64 {
        while b != 0 {
            let temp = b;
            b = a % b;
            a = temp;
        }
        a
    }

    fn lcm(a: i64, b: i64) -> i64 {
        (a / Self::gcd(a, b)) * b
    }

    fn count_magical(x: i64, a: i64, b: i64, common_lcm: i64) -> i64 {
        (x / a) + (x / b) - (x / common_lcm)
    }
}