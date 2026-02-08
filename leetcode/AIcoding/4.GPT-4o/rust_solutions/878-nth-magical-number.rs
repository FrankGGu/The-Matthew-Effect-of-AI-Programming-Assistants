impl Solution {
    pub fn nth_magical_number(n: i32, a: i32, b: i32) -> i32 {
        const MOD: i32 = 1_000_000_007;
        let lcm = a / gcd(a, b) * b;
        let cycle_length = lcm / a + lcm / b;
        let full_cycles = n / cycle_length;
        let remaining = n % cycle_length;

        let mut count = 0;
        let mut result = 0;
        let mut i = 1;
        let mut j = 1;

        while count < remaining {
            if a * i < b * j {
                result = a * i;
                i += 1;
            } else {
                result = b * j;
                j += 1;
            }
            count += 1;
        }

        (result + full_cycles * lcm) % MOD
    }
}

fn gcd(x: i32, y: i32) -> i32 {
    if y == 0 {
        x
    } else {
        gcd(y, x % y)
    }
}