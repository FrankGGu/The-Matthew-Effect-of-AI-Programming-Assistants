impl Solution {
    pub fn number_of_ways(start_pos: i32, end_pos: i32, k: i32) -> i32 {
        let diff = (end_pos - start_pos).abs();
        if diff > k || (k - diff) % 2 != 0 {
            return 0;
        }
        let steps = (k - diff) / 2;
        let total_steps = k;
        let mut result = 1;
        let mut denom = 1;

        for i in 0..steps {
            result = result * (total_steps - i) % 1_000_000_007;
            denom = denom * (i + 1) % 1_000_000_007;
        }

        (result * mod_inverse(denom, 1_000_000_007)) % 1_000_000_007
    }
}

fn mod_inverse(a: i32, m: i32) -> i32 {
    let (mut m0, mut x0, mut x1) = (m, 0, 1);
    let mut a = a % m;
    while a > 1 {
        let q = a / m0;
        let t = m0;
        m0 = a % m0;
        a = t;
        let t = x0;
        x0 = x1 - q * x0;
        x1 = t;
    }
    if x1 < 0 {
        x1 += m;
    }
    x1
}