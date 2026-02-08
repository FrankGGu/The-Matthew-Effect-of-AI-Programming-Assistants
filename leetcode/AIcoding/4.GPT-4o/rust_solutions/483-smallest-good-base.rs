impl Solution {
    pub fn smallest_good_base(n: String) -> String {
        let n: u64 = n.parse().unwrap();
        let max_power = (n as f64).log(2.0).floor() as u64;

        for m in (2..=max_power).rev() {
            let k = (n as f64).powf(1.0 / m as f64);
            let base = k.floor() as u64;
            let sum = (1u64 << (m + 1)) - 1;
            let num = base.checked_sub(1).unwrap_or(0);
            if num > 0 && (base * sum) / num == n {
                return base.to_string();
            }
        }
        (n - 1).to_string()
    }
}