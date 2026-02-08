struct Solution;

impl Solution {
    fn gcd(mut a: i64, mut b: i64) -> i64 {
        while b != 0 {
            let temp = b;
            b = a % b;
            a = temp;
        }
        a
    }

    fn lcm(a: i64, b: i64) -> i64 {
        if a == 0 || b == 0 {
            return 0;
        }
        // To prevent overflow, divide by gcd first
        a / Self::gcd(a, b) * b
    }

    fn count_ugly_numbers(num: i64, a: i64, b: i64, c: i64) -> i64 {
        let count_a = num / a;
        let count_b = num / b;
        let count_c = num / c;

        let lcm_ab = Self::lcm(a, b);
        let lcm_ac = Self::lcm(a, c);
        let lcm_bc = Self::lcm(b, c);

        let count_ab = num / lcm_ab;
        let count_ac = num / lcm_ac;
        let count_bc = num / lcm_bc;

        let lcm_abc = Self::lcm(Self::lcm(a, b), c);
        let count_abc = num / lcm_abc;

        count_a + count_b + count_c - count_ab - count_ac - count_bc + count_abc
    }

    pub fn nth_ugly_number(n: i32, a: i32, b: i32, c: i32) -> i32 {
        let n = n as i64;
        let a = a as i64;
        let b = b as i64;
        let c = c as i64;

        let mut low: i64 = 1;
        let mut high: i64 = 2_000_000_000; // Max possible answer fits in i32, so 2*10^9 is a safe upper bound.

        let mut ans: i64 = high; 

        while low <= high {
            let mid = low + (high - low) / 2;
            if Self::count_ugly_numbers(mid, a, b, c) >= n {
                ans = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }
        ans as i32
    }
}